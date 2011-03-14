# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :report do |f|
  f.reportable_id       1
  f.reportable_type     "Brand"
  f.document_file_name    "MyString"
  f.document_content_type "MyString"
  f.document_file_size    1
  f.document_updated_at   "2011-03-13 19:37:37"
end