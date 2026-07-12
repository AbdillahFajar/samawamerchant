# Dokumen Implementasi

<div align="center">
  <img src="https://github.com/user-attachments/assets/24ff1705-2151-4efa-87b3-9ab09a40c8af" alt="Logo Global" width="200"/>
  <br/>
  <p>Institut Teknologi dan Bisnis Bina Sarana Global</p>
</div>
<div align="center">
FAKULTAS TEKNOLOGI INFORMASI & KOMUNIKASI 
<br>
https://global.ac.id/
  </div>

# Samawa Merchant

Marketplace berbasis mobile yang dirancang untuk memfasilitasi transaksi jual beli antara pelaku usaha (Merchant) dan konsumen (Customer) di lingkungan **Perumahan Samawa Village**.

Aplikasi dikembangkan menggunakan **Flutter** sebagai frontend, **Golang (Gin Framework)** sebagai backend REST API, **MySQL** sebagai database, serta **Firebase Authentication** dan **Firebase Cloud Messaging (FCM)** sebagai layanan autentikasi dan notifikasi.

---

# Daftar Isi

- Deskripsi
- Fitur Aplikasi
- Arsitektur Sistem
- Teknologi yang Digunakan
- Struktur Proyek
- Struktur Database
- REST API
- Instalasi Backend
- Instalasi Frontend
- Konfigurasi Firebase
- Menjalankan Aplikasi
- Screenshot Aplikasi
- Troubleshooting
- Demo Video
- Developer

---

# Deskripsi

Samawa Merchant merupakan aplikasi marketplace berbasis mobile yang digunakan sebagai media transaksi jual beli antara pelaku usaha dan konsumen di lingkungan Perumahan Samawa Village.

Sistem dibangun menggunakan konsep **Clean Architecture** pada sisi frontend sehingga setiap fitur dipisahkan menjadi lapisan **Data**, **Domain**, dan **Presentation**. Backend dikembangkan menggunakan Golang dengan framework Gin serta menggunakan GORM sebagai ORM untuk mengelola database MySQL.

Aplikasi menyediakan dua jenis pengguna, yaitu **Customer** dan **Merchant**. Customer dapat mencari produk, melakukan pemesanan, checkout, serta mengunggah bukti pembayaran. Merchant dapat mengelola toko, produk, metode pembayaran, memverifikasi pembayaran, serta memperbarui status pesanan.

---

# Fitur Aplikasi

## Customer

- Registrasi akun
- Login menggunakan Email
- Login menggunakan Google
- Melihat katalog produk
- Mencari produk
- Filter produk berdasarkan kategori
- Melihat detail produk
- Menambahkan produk ke keranjang
- Checkout pesanan
- Upload bukti pembayaran
- Melihat riwayat pesanan
- Melihat perkembangan status pesanan

---

## Merchant

- Registrasi Merchant
- Mengelola profil toko
- Mengubah status toko (Buka/Tutup)
- Menambah produk
- Mengubah produk
- Menghapus produk
- Mengubah status produk
- Mengelola metode pembayaran
- Melihat pesanan masuk
- Memverifikasi pembayaran
- Mengubah status pesanan

---

# Arsitektur Sistem

```
Flutter Mobile Application
            │
            │ REST API
            ▼
     Gin Framework Backend
            │
            ▼
      MySQL Database

Firebase Authentication
Firebase Cloud Messaging
```

---

# Teknologi yang Digunakan

| Komponen | Teknologi |
|----------|-----------|
| Frontend | Flutter |
| Backend | Golang |
| Backend Framework | Gin |
| ORM | GORM |
| Database | MySQL |
| Authentication | Firebase Authentication |
| Notification | Firebase Cloud Messaging |
| State Management | Provider |
| Architecture | Clean Architecture |
| API | REST API |

---

# Arsitektur Proyek

## Frontend

```
lib/
│
├── core/                  # Komponen yang digunakan secara global oleh seluruh aplikasi
│   ├── constants/         # Konstanta aplikasi (warna, string, endpoint, dll)
│   ├── providers/         # State management global menggunakan Provider
│   ├── routes/            # Konfigurasi navigasi aplikasi
│   ├── services/          # Service umum (Firebase, Notification, SharedPreferences, dll)
│   ├── theme/             # Tema dan style aplikasi
│   └── widgets/           # Widget yang dapat digunakan kembali (reusable widget)
│
├── features/              # Seluruh fitur utama aplikasi (Clean Architecture)
│   ├── auth/              # Fitur autentikasi pengguna
│   │   ├── data/          # Model, repository, dan data source
│   │   ├── domain/        # Entity, repository interface, dan use case
│   │   └── presentation/  # Halaman, provider, dan widget autentikasi
│   │
│   ├── catalog/           # Fitur katalog produk
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── cart/              # Fitur keranjang belanja
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── order/             # Fitur checkout dan pengelolaan pesanan
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── merchant/          # Fitur dashboard merchant
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── payment_method/    # Fitur pengelolaan metode pembayaran merchant
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── customer_main_page.dart # Halaman utama Customer
├── firebase_options.dart   # Konfigurasi Firebase
└── main.dart               # Entry point aplikasi
```
---

## Backend

```
GO-SAMAWAMERCHANT/
│
├── config/          # Konfigurasi database, Firebase, dan environment
├── handlers/        # Handler untuk menerima request API
├── logs/            # Penyimpanan log aplikasi
├── middleware/      # Middleware autentikasi dan otorisasi
├── models/          # Model yang merepresentasikan tabel database
├── package/         # Package atau utilitas tambahan
├── repositories/    # Interaksi langsung dengan database
├── routes/          # Definisi seluruh endpoint REST API
├── services/        # Logika bisnis aplikasi
├── uploads/         # Penyimpanan file upload bukti pembayaran
│
├── .env             # Konfigurasi environment
├── .air.toml        # Konfigurasi Air (hot reload Golang)
├── go.mod           # Daftar dependency Go
├── go.sum           # Checksum dependency Go
├── main.go          # Entry point backend
└── samawamerchant.json # Konfigurasi Firebase Admin SDK
```
---

# Struktur Database

Nama Database

```
samawamerchanttest
```

### Daftar Tabel

- users
- merchants
- products
- cart_items
- orders
- order_items
- payment_methods
- payment_transactions

<p align="center">
  <img src="screenshots/erd.png" width="850">
</p>

---

# REST API

Base URL

```
http://localhost:8081/v1
```

---

## Authentication

| Method | Endpoint |
|----------|---------------------------|
| POST | /auth/verify-token |
| GET | /auth/me |
| PUT | /auth/profile |
| PUT | /auth/fcm-token |

---

## Product

| Method | Endpoint |
|---------|----------------|
| GET | /products |
| GET | /products/{id} |

---

## Cart

| Method | Endpoint |
|---------|----------------|
| GET | /cart |
| POST | /cart |
| PUT | /cart/{id} |
| DELETE | /cart |
| DELETE | /cart/{id} |

---

## Orders

| Method | Endpoint |
|---------|-------------------------------|
| GET | /orders |
| GET | /orders/{id} |
| POST | /orders/checkout |
| PATCH | /orders/{id}/payment-proof |

---

## Merchant Public

| Method | Endpoint |
|---------|----------------|
| GET | /merchant-public |
| POST | /merchant-public |

---

## Merchant

### Merchant Profile

| Method | Endpoint |
|---------|----------------|
| PUT | /merchant |
| PATCH | /merchant/status |

---

### Merchant Product

| Method | Endpoint |
|---------|------------------------------|
| GET | /merchant/products |
| GET | /merchant/products/{id} |
| POST | /merchant/products |
| PUT | /merchant/products/{id} |
| DELETE | /merchant/products/{id} |
| PATCH | /merchant/products/{id}/status |
| PATCH | /merchant/products/status/bulk |

---

### Merchant Orders

| Method | Endpoint |
|---------|---------------------------------------|
| GET | /merchant/orders |
| GET | /merchant/orders/{orderID} |
| PATCH | /merchant/orders/{orderID}/status |
| PATCH | /merchant/orders/{orderID}/payment-status |

---

### Merchant Payment Method

| Method | Endpoint |
|---------|--------------------------------|
| GET | /merchant/payment-methods |
| GET | /merchant/payment-methods/{id} |
| POST | /merchant/payment-methods |
| PUT | /merchant/payment-methods/{id} |
| DELETE | /merchant/payment-methods/{id} |

---

## Customer Payment Method

| Method | Endpoint |
|---------|----------------------------|
| GET | /payment-methods/{merchantID} |

---

# Instalasi Backend

Clone repository

```bash
git clone https://github.com/AbdillahFajar/go-samawamerchant-testserver.git
```

Masuk ke folder backend

```bash
cd go-samawamerchant-testserver
```

Install dependency

```bash
go mod tidy
```

Buat file `.env` sesuai konfigurasi database.

Contoh konfigurasi:

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=samawamerchanttest
DB_USER=root
DB_PASSWORD=
JWT_SECRET=your_secret_key
```

---

# Menjalankan Backend

Menggunakan Go

```bash
go run main.go
```

atau menggunakan Air

```bash
air
```

Server akan berjalan pada

```
http://localhost:8081
```

---

# Instalasi Frontend

Masuk ke folder project Flutter

```bash
flutter pub get
```

Pastikan file berikut telah tersedia

```
android/app/google-services.json
```

Jalankan aplikasi

```bash
flutter run
```

---

# Konfigurasi Firebase

Layanan Firebase yang digunakan

- Firebase Authentication
- Firebase Cloud Messaging (FCM)

Pastikan project Firebase telah dikonfigurasi dan file

```
google-services.json
```

telah ditempatkan pada folder

```
android/app/
```

---

# Menjalankan Aplikasi

1. Jalankan MySQL.
2. Import database `samawamerchanttest`.
3. Jalankan Backend menggunakan `go run main.go` atau `air`.
4. Jalankan aplikasi Flutter menggunakan `flutter run`.
5. Login menggunakan Email atau Google.
6. Aplikasi siap digunakan.

---

# Screenshot Aplikasi

Seluruh tampilan antarmuka aplikasi Samawa Merchant dikelompokkan berdasarkan jenis pengguna, yaitu **Customer**, dan **Merchant**.

---

### Splash Screen

<p align="center">
  <img src="screenshots/User/halaman_splash.jpeg" width="260">
</p>

---

### Login

<table align="center">
<tr>
<td align="center">

**Login Email**

<img src="screenshots/User/halaman_login.jpeg" width="260">

</td>

<td align="center">

**Login Google**

<img src="screenshots/User/login_google.jpeg" width="260">

</td>
</tr>
</table>

---

### Registrasi

<p align="center">
  <img src="screenshots/User/halaman_registrasi.jpeg" width="260">
</p>

---

# Customer

## Dashboard Customer

<p align="center">
  <img src="screenshots/Customer/halaman_dashboard_customer.jpeg" width="270">
</p>

---

## Katalog Produk

<table align="center">
<tr>

<td align="center">

**Detail Produk**

<img src="screenshots/Customer/halaman_detail_produk.jpeg" width="250">

</td>

</tr>
</table>

---

## Pendaftaran Merchant

<p align="center">
  <img src="screenshots/Customer/form_daftar_merchant.jpeg" width="270">
</p>

---

## Keranjang

<p align="center">
  <img src="screenshots/Customer/halaman_keranjang.jpeg" width="270">
</p>

---

## Checkout

<table align="center">
<tr>

<td align="center">

**Checkout Header**

<img src="screenshots/Customer/halaman_checkout_header.jpeg" width="250">

</td>

<td align="center">

**Checkout Detail**

<img src="screenshots/Customer/halaman_checkout_detail.jpeg" width="250">

</td>

</tr>
</table>

---

## Riwayat Pesanan

<table align="center">
<tr>

<td align="center">

**Daftar Pesanan**

<img src="screenshots/Customer/halaman_order_header.jpeg" width="250">

</td>

<td align="center">

**Detail Pesanan**

<img src="screenshots/Customer/halaman_order_detail.jpeg" width="250">

</td>

</tr>
</table>

---

## Pengaturan Akun

<p align="center">
  <img src="screenshots/Customer/halaman_pengaturan_akun_customer.jpeg" width="270">
</p>

---

## Notifikasi

<p align="center">
  <img src="screenshots/Customer/notifikasi_pembaruan_status_pesanan.jpeg" width="270">
</p>

---

# Merchant

## Dashboard Merchant

<p align="center">
  <img src="screenshots/Merchant/halaman_header_pesanan_merchant.jpeg" width="270">
</p>

---

## Pengaturan Merchant

<p align="center">
  <img src="screenshots/Merchant/halaman_pengaturan.jpeg" width="270">
</p>

---

## Kelola Produk

<table align="center">

<tr>

<td align="center">

**Daftar Produk**

<img src="screenshots/Merchant/halaman_list_produk.jpeg" width="220">

</td>

<td align="center">

**Tambah Produk**

<img src="screenshots/Merchant/halaman_tambah_produk.jpeg" width="220">

</td>

<td align="center">

**Edit Produk**

<img src="screenshots/Merchant/halaman_edit_produk.jpeg" width="220">

</td>

</tr>

<tr>

<td align="center">

**Dialog Hapus**

<img src="screenshots/Merchant/dialog_hapus_produk.jpeg" width="220">

</td>

<td align="center">

**Dialog Konfirmasi Bulk Status**

<img src="screenshots/Merchant/dialog_konfirmasi_bulk_status.jpeg" width="220">

</td>

<td align="center">

**Snackbar Bulk Status Disable**

<img src="screenshots/Merchant/snackbar_bulk_status_disable.jpeg" width="220">

</td>

</tr>

</table>

---

## Kelola Metode Pembayaran

<table>

<tr>

<td align="center">

**Halaman Metode Pembayaran**

<img src="screenshots/Merchant/halaman_metode_pembayaran.jpeg" width="220">

</td>

<td align="center">

**Cash**

<img src="screenshots/Merchant/form_cash.jpeg" width="220">

</td>

<td align="center">

**Transfer Bank**

<img src="screenshots/Merchant/form_transfer_bank.jpeg" width="220">

</td>

</tr>

<tr>

<td align="center">

**E-Wallet**

<img src="screenshots/Merchant/form_e_wallet.jpeg" width="220">

</td>

<td align="center">

**QRIS**

<img src="screenshots/Merchant/form_qris.jpeg" width="220">

</td>

<td align="center">

**Edit Transfer Bank/E-Wallet**

<img src="screenshots/Merchant/form_edit_e_wallet.jpeg" width="220">

</td>

</tr>

</table>

---

## Kelola Pesanan

<table>

<tr>

<td align="center">

**Detail Pesanan**

<img src="screenshots/Merchant/halaman_detail_pesanan_merchant.jpeg" width="230">

</td>

<td align="center">

**Konfirmasi Kelola Toko**

<img src="screenshots/Merchant/dialog_konfirmasi_kelola_toko.jpeg" width="230">

</td>

<td align="center">

**Konfirmasi Status Pesanan**

<img src="screenshots/Merchant/dialog_konfirmasi_status_pesanan.jpeg" width="230">

</td>

</tr>

<tr>

<td align="center">

**Ubah Status Pembayaran**

<img src="screenshots/Merchant/dialog_ubah_status_pembayaran.jpeg" width="230">

</td>

<td align="center">

**Notifikasi Pesanan Baru**

<img src="screenshots/Merchant/notifikasi_pesanan_baru.jpeg" width="230">

</td>

<td></td>

</tr>

</table>

---

# Troubleshooting

## Backend tidak dapat dijalankan

- Pastikan MySQL telah aktif.
- Pastikan database telah dibuat.
- Pastikan konfigurasi `.env` sudah benar.

---

## Login Google gagal

Pastikan SHA-1 telah ditambahkan pada Firebase Project.

---

## Flutter tidak dapat mengakses Backend

Pastikan alamat BASE_URL mengarah ke server backend.

Contoh

```
http://10.0.2.2:8081
```

untuk Android Emulator.

Gunakan IP Address komputer apabila menggunakan perangkat Android fisik.

---

## Upload Bukti Pembayaran gagal

Pastikan folder

```
uploads/
```

memiliki hak akses untuk menulis file.

---

# Demo Video
Lihat video demo aplikasi untuk mendapatkan penjelasan dari semua fitur Samawa Merchant

**[Samawa Merchant Demo Video #1](https://youtu.be/lIS33_5NQ64?si=G05NiZneTvCxuDu1)**

---

# Developer

**Nama**

Fajar Abdillah

**Program Studi**

Teknik Informatika

**Universitas**

Institut Teknologi dan Bisnis Bina Sarana Global

---

# Lisensi

Proyek ini dikembangkan sebagai bagian dari penelitian proyek Program Studi Teknik Informatika Institut Teknologi dan Bisnis Bina Sarana Global.