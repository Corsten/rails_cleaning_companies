class ClientsReportService < BaseReportService
  def initialize
    @data = Client.all
  end

  private

  def report_table_header
    [translate('client.', 'id'), translate('client.', 'name'),
     translate('client.', 'surname'), translate('client.', 'email'),
     translate('client.', 'phone_number')]
  end

  def report_table_info(client)
    [client.id, client.name, client.surname, client.email, client.phone_number]
  end
end
