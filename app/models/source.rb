class Source < ActiveRecord::Base

  belongs_to :user
  has_many :source_fields

  accepts_nested_attributes_for :source_fields

  validates :source_id, presence: true, length: { minimum: 10  }, uniqueness: {scope: [:user_id]}

  after_save :create_or_update_hbase
  after_create :create_kafka_topic

  HBASE_CLIENT = Stargate::Client.new("http://localhost:12323")

  def api_source_id
    "#{self.user.api_key}::#{self.source_id}"
  end

  def create_kafka_topic
    system "#{ENV['KAFKA_HOME']}/bin/kafka-topics.sh --topic #{api_source_id} --create --partitions 1 --replication-factor 1 --zookeeper localhost:2181"
  end

  def publish_success_count
    published_rows.select {|col| col.name.include? "success"}.count #rescue 0
  end

  def publish_failure_count
    published_rows.select {|col| col.name.include? "failed"}.count #rescue 0
  end

  def published_rows
    @rows ||= HBASE_CLIENT.show_row('apiRequestTable', api_source_id).columns rescue []
  end

  private

  def create_or_update_hbase
    # HBASE_CLIENT.create_row('source', "#{api_source_id}", Time.now.to_i, {name: "metadata:metadata", value: {name: self.name, event_type: self.event_type}.to_json})
    HBASE_CLIENT.create_row('source', "#{api_source_id}", Time.now.to_i, {name: "fields:fields", value: source_fields.collect(&:as_json).to_json})
  end

end

#
# val theget = new Get(Bytes.toBytes("5022d9105e2a0132e43c0a5f603a4ac0::ask4prasath"))
# theget.addFamily(Bytes.toBytes("success"))
# theget.setMaxVersions(45)
# val result = apiRequestTable.get(theget)
# val stringresult = Bytes.toString(value)
#
# import org.apache.hadoop.hbase.client.{Delete, HBaseAdmin, HTable, Put, Result => HBaseResult, Scan}
#
#
#
# val scan = new Scan(Bytes.toBytes("5022d9105e2a0132e43c0a5f603a4ac0::ask4prasath"))
# scan.addFamily(Bytes.toBytes("success"))
# val scanner = apiRequestTable.getScanner(scan)
# scanner.next.list.size
#
#
# val scan = new Scan(Bytes.toBytes("5022d9105e2a0132e43c0a5f603a4ac0::ask4prasath"))
# scan.addFamily(Bytes.toBytes("failed"))
# val scanner = apiRequestTable.getScanner(scan)
# scanner.next.list.size
#
#


