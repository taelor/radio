module ApplicationHelper
  
  include ActsAsTaggableOn::TagsHelper
  
  def layout_menu_item(label, url)
    if controller_name == "home"
      if action_name == label.downcase
        "<li class='current_page_item'>#{link_to(label, url)}</li>".html_safe
      else
        "<li>#{link_to(label, url)}</li>".html_safe
      end
    elsif controller_name == label.downcase
      "<li class='current_page_item'>#{link_to(label, url)}</li>".html_safe
    else
      "<li>#{link_to(label, url)}</li>".html_safe
    end
  end
  
  def detail_row(title, value)
    value ||= "&nbsp;"
    "<tr>
      <th>#{title}</th>
      <td>#{value}</td>
    </tr>".html_safe
  end
end
