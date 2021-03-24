class BaseReport
  REPORTER_MAP = [::ClientReport].freeze
  def export(kind, filters)
    REPORTER_MAP.each do |reporter|
      @instance = reporter.new if reporter.can_make?(kind)
    end
    @instance.make_report(kind, filters)
  end

  def make_xsls(kind, data)
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook_styles = {}
    styles.each { |name, style| workbook_styles[name] = workbook.styles.add_style(style) }

    workbook.add_worksheet(name: kind) do |sheet|
      sheet.add_row(report_table_header, style: workbook_styles[:header])
      data.each { |elem| sheet.add_row(report_table_info(elem), style: workbook_styles[:default_cell]) }
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
