RailsAdmin.config do |config|
  config.authorize_with do
    unless current_user.role_id == 2
      redirect_to main_app.root_path
      flash[:danger] = "Bạn không phải admin"
    end
  end

  config.main_app_name = ["Trang admin", ""]
  config.included_models = ["Role", "User", "Parking", "Order", "Review"]

  config.model "User" do
    list do
      exclude_fields :reset_password_sent_at, :remember_created_at, :created_at,
        :updated_at, :parking, :orders, :reviews, :parkings
      fields :name do
        label "Họ tên"
      end
      fields :phone_number do
        label "SĐT"
      end
    end
  end

  config.model "Review" do
    list do
      exclude_fields :created_at, :updated_at
      fields :user do
        label "Tên người dùng"
      end
      fields :parking do
        label "Bãi đỗ"
      end
    end
  end

  config.model "Parking" do
    list do
      exclude_fields :created_at, :updated_at, :orders, :reviews, :users
      fields :user do
        label "Chủ bãi đỗ"
      end
      fields :name do
        label "Tên bãi"
      end
      fields :waiting_time do
        label "Thời gian chờ"
      end
      fields :address do
        label "Địa chỉ"
      end
    end
  end

  config.model "Order" do
    list do
      exclude_fields :created_at, :updated_at
      fields :car_number do
        label "Biển số xe"
      end
      fields :type_booked do
        label "Loại đặt"
      end
      fields :status do
        label "Trạng thái"
      end
    end
  end

  config.actions do
    dashboard
    index
    new do
      except ["Order", "Parking", "Review", "User"]
    end
    export do
      except ["Role"]
    end
    bulk_delete do
      except ["Order", "Parking", "Review", "User"]
    end
    show
    edit do
      except ["Order", "Parking", "Review", "User"]
    end
    delete do
      except ["Order", "Parking", "Review", "User"]
    end
    show_in_app
  end
end
