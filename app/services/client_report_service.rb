class ClientReportService < BaseReportService
  def self.can_make?(kind)
    true if kind == 'Client'
  end

  def make_report(kind, data, type)
    make_xsls(kind, data) if type == 'xlsx'
  end

  def report_table_header
    [translate('client.', 'id'), translate('client.', 'name'),
     translate('client.', 'surname'), translate('client.', 'email'),
     translate('client.', 'phone_number')]
  end

  def report_table_info(client)
    [client.id, client.name, client.surname, client.email, client.phone_number]
  end
end
