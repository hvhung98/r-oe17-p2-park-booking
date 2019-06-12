RailsAdmin.config do |config|
  config.authorize_with do
    unless user_signed_in? && current_user.role_id == 2
      redirect_to main_app.root_path
      flash[:danger] = "Bạn không phải là admin"
    end
  end

  config.main_app_name = ["Trang admin", ""]
  config.included_models = ["Role", "User", "Parking", "Order", "Review"]

  config.model "User" do
    list do
      include_fields :name, :email, :phone_number, :score, :role
      fields :name do
        label "Tên"
      end
      fields :phone_number do
        label "Số điện thoại"
      end
      fields :score do
        label "Uy tín"
      end
      fields :role do
        label "Quyền"
      end
    end
  end

  config.model "Order" do
    list do
      exclude_fields :created_at, :updated_at
      fields :orderable do
        label "Tên bãi đỗ"
      end
      fields :car_number do
        label "Biển số xe"
      end
      fields :type_booked do
        label "Thể loại đặt"
      end
      fields :status do
        label "Trạng thái"
      end
      fields :month_booked do
        label "Tháng đặt"
      end
      fields :day_booked do
        label "Ngày đặt"
      end
      fields :price do
        label "Tổng giá"
      end
      fields :user do
        label "Người đặt"
      end
    end
  end

  config.model "Parking" do
    list do
      include_fields :name, :address, :description, :total_position, :time_open,
        :time_close, :price
      fields :name do
        label "Tên bãi đỗ"
      end
      fields :address do
        label "Địa chỉ"
      end
      fields :description do
        label "Mô tả"
      end
      fields :total_position do
        label "Tổng vị trí"
      end
      fields :time_open do
        label "Thời gian mở cửa"
      end
      fields :time_close do
        label "Thời gian đóng cửa"
      end
      fields :price do
        label "Giá tiền"
      end
    end
  end

  config.model "Role" do
    list do
      exclude_fields :created_at, :updated_at, :id
      fields :name do
        label "Quyền"
      end
      fields :users do
        label "Người dùng"
      end
    end
  end

  config.actions do
    dashboard
    index
    new do
      only ["Role"]
    end

    export do
      except ["Role"]
    end

    bulk_delete do
      only ["Role"]
    end
    show
    edit do
      only ["Role"]
    end
    delete do
      only ["Role"]
    end
    show_in_app do
      only ["User"]
    end
  end
end
