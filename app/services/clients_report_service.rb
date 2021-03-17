class ClientsService < BaseReportService
  def initialize
    @clients = Client.all
  end

  def export_to_xlsx_stream
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook_styles = {}
    styles.each { |name, style| workbook_styles[name] = workbook.styles.add_style(style) }

    workbook.add_worksheet(name: 'Clients') do |sheet|
      sheet.add_row(report_table_header, style: workbook_styles[:header])
      @clients.each { |client| sheet.add_row(report_table_client_info(client), style: workbook_styles[:default_cell]) }
    end

    package.to_stream.read
  end

  private

  def styles
    {
      header: {
        border: { color: 'FF000000', style: :medium },
        font_name: 'Arial',
        sz: 11,
        b: true,
        alignment: { horizontal: :center }
      },
      default_cell: {
        border: { color: 'FF000000', style: :thin },
        font_name: 'Arial',
        sz: 11,
        b: false,
        alignment: { horizontal: :left }
      }
    }
  end

  def translate(key)
    I18n.t('activerecord.attributes.client.' + key)
  end

  def report_table_header
    header = [translate('id'), translate('name'), translate('surname'),
              translate('email'), translate('phone_number')]
  end

  def report_table_client_info(client)
    [client.id, client.name, client.surname, client.email, client.phone_number]
  end
end
