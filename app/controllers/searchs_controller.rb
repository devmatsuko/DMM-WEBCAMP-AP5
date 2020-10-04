class SearchsController < ApplicationController
  
  def search
    # 検索対象のモデル："Book", "User"
    @model = params["model"]
    # 検索ワード
    @content = params["content"]
    # 検索方法："完全一致","前方一致","後方一致","部分一致"
    how = params["how"]
    # model,content,howを元に検索した結果をdatasに格納する
    @datas = search_for(how, @model, @content)
  end
    
  private
  def match(model, content)
    if model == 'User'
      User.where(name: content)
    elsif model == 'Book'
      Book.where(title: content)
    end
  end
  
  def forward(model, content)
    if model == 'User'
      User.where("name LIKE ?", "#{content}%")
    elsif model == 'Book'
      Book.where("title LIKE ?", "#{content}%")
    end
  end
  
  def backward(model, content)
    if model == 'User'
      User.where("name LIKE ?", "%#{content}")
    elsif model == 'Book'
      Book.where("title LIKE ?", "%#{content}")
    end
  end
  
  def partical(model, content)
    if model == 'User'
      User.where("name LIKE ?", "%#{content}%")
    elsif model == 'Book'
      Book.where("title LIKE ?", "%#{content}%")
    end
  end
  
  def search_for(how, model, content)
    case how
    when 'perfect'
      match(model, content)
    when 'front'
      forward(model, content)
    when 'back'
      backward(model, content)
    when 'part'
      partical(model, content)
    end
  end
end
