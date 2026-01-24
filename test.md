# Todo List
## Mục tiêu dự án
Xây dựng ứng dụng Todo List cho phép người dùng quản lý công việc hằng ngày. Ứng dụng phải tuân theo Clean Architecture, sử dụng Cubit (flutter_bloc) để quản lý state, điều hướng bằng GoRouter, gọi API bằng Dio, quản lý dependency bằng GetIt, và validate form bằng Formz.

Design: https://www.figma.com/design/4gLRnkdgQPlHn4XUcw9qNS/Loading-Monkey-Stories?node-id=998-7074&t=im7k6zEWiZa2bqtN-4

## Chức năng bắt buộc
### 1. Todo Management
- Xem danh sách todo
- Thêm todo mới
- Sửa todo
- Xóa todo
- Đánh dấu todo hoàn thành / chưa hoàn thành

### 2. Authentication
- Đăng nhập bằng email + password
- Validate form bằng Formz
- Lưu trạng thái đăng nhập cục bộ
- Tự động redirect:
    - Chưa đăng nhập → màn hình Login
    - Đã đăng nhập → màn hình Todo List

### 3. Error Handling
- Hiển thị loading
- Error

### 4. Cấu trúc Project

```
lib/
├── core/
│   ├── di/
│   │   └── injection.dart
│   ├── network/
│   │   ├── dio_client.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── error/
│   │   ├── failure.dart
│   │   └── exception.dart
│   ├── constants/
│   │   └── app_constants.dart
│   └── utils/
│       └── validators.dart
│
├── domain/
│   ├── entities/
│   │
│   ├── repositories/
│   │
│   └── usecases/
│
├── data/
│   ├── models/
│   │
│   ├── datasources/
│   │   ├── remote/
│   │   └── local/
│   │
│   ├── repositories/
│   │
│   └── mappers/
│       └── todo_mapper.dart
│
├── presentation/
│   ├── cubit/
│   └── pages/
│   └── widgets/
│
└── main.dart

```


### 5. Yêu cầu Code Quality
- Tuân thủ SOLID
- Không logic trong Widget
- Có comment cho UseCase và Cubit
- Tên biến, class rõ nghĩa
- Không hardcode (sử dụng constants)