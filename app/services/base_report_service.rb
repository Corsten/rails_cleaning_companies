class BaseReportService
  class << self
    def export(list_name)
      instance = new
      instance.export_to_xlsx_stream(list_name)
    end

    def filename(filename)
      "#{filename}.xlsx"
    end

    def type
      'application/vnd.ms-excel'
    end
  end

  def export_to_xlsx_stream(list_name)
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook_styles = {}
    styles.each { |name, style| workbook_styles[name] = workbook.styles.add_style(style) }

    workbook.add_worksheet(name: list_name) do |sheet|
      sheet.add_row(report_table_header, style: workbook_styles[:header])
      @data.each { |client| sheet.add_row(report_table_info(client), style: workbook_styles[:default_cell]) }
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

  def translate(model, key)
    I18n.t('activerecord.attributes.' + model + key)
  end
end
