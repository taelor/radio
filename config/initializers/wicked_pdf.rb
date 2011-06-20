
exe_path = (RAILS_ENV == "production") ?
  Rails.root.join('bin', 'wkhtmltopdf').to_s :
  '/usr/local/bin/wkhtmltopdf'

WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  :exe_path => exe_path
}

