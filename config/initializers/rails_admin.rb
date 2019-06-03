RailsAdmin.config do |config|

  config.authorize_with do
    unless user_signed_in? and current_user.role_id == 2
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
      include_fields :car_number, :price, :status, :type_booked, :created_at
      fields :car_number do
        label "Biển số xe"
      end
      fields :price do
        label "Giá theo giờ"
      end
      fields :status do
        label "Trạng thái"
      end
      fields :type_booked do
        label "Loại hóa đơn"
      end
      fields :created_at do
        label "Thời gian đặt"
      end
    end
  end

  config.model "Parking" do
    list do
      include_fields :name, :address, :description, :total_position, :time_open, :time_close
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

  config.model "Review" do
    list do
      exclude_fields :created_at, :updated_at, :id
      fields :rating do
        label "Đánh giá"
      end
      fields :comment do
        label "Nhận xét"
      end
      fields :user do
        label "Người đánh giá"
      end
      fields :parking do
        label "Bãi đỗ xe"
      end
    end
  end

  config.actions do
    dashboard
    index

    export do
      except ["Role"]
    end

    bulk_delete do
      only ["Review"]
    end
    show
    show_in_app do
      only ["User", "Parking", "Order"]
    end
  end
end
