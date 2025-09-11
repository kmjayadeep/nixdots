# NixOS Configuration TODO List

## 🔒 Security Improvements (HIGH PRIORITY)

### Critical Security Issues
- [ ] **Remove hardcoded password** in `modules/system.nix` line 71
  - Either remove `initialPassword = "password";` entirely
  - Or replace with `hashedPassword` using proper hash
- [ ] **Address insecure package** in `modules/default.nix` lines 29-31
  - Update `qtwebengine-5.15.19` to newer version
  - Or find alternative package
  - Remove from `permittedInsecurePackages` list
- [x] **Verify SSH security** ✅ COMPLETED
  - ✅ Fixed permissions on `/home/jayadeep/private/ssh/` (700) and `config` (600)
  - ✅ Added SSH hardening configuration (simplified but secure)
  - ✅ Password authentication enabled for user `jayadeep` only (secure approach)
  - ✅ Added fail2ban protection against brute force attacks (simplified config)
  - Refer https://richard-sebos.github.io/sebostechnology/posts/Fail2Ban/ and configure fail2ban properly

## 🏗️ Code Organization & Modularity

### Reduce Duplication
- [x] **Extract NFS server configuration** ✅ COMPLETED
  - ✅ Created variables for server, base path, options, and timeout
  - ✅ Converted to functional approach using `map` and helper functions
  - ✅ Eliminated all duplication - now easy to add/remove NFS shares

### Module Management
- [x] **Clean up commented modules** in `default.nix` ✅ COMPLETED
  - ✅ Organized imports into logical categories (Core, Desktop, Services)
  - ✅ Added clear comments explaining purpose of each section
  - ✅ Kept unused DE modules commented with usage notes
- [x] **Organize package categories** in `packages.nix` ✅ COMPLETED
  - ✅ Grouped packages into 8 clear categories with descriptive headers
  - ✅ Added inline comments explaining each package's purpose
  - ✅ Organized by: System, Development, Desktop, Network, Browsers, Media, Gaming, Hardware

## ⚡ Performance Optimizations

### Nix Configuration
- [x] **Enhance Nix settings** in `nixos.nix` ✅ COMPLETED
  - ✅ Added `max-jobs = "auto"` for parallel builds
  - ✅ Added `cores = 0` to use all available CPU cores
  - ✅ Added Cachix and nix-community substituters for faster builds
  - ✅ Added trusted public keys for binary cache verification
  - ✅ Added `builders-use-substitutes = true` for additional optimization
- [x] **Optimize font loading** in `fonts.nix` ✅ COMPLETED
  - ✅ Added optimized hinting style and subpixel rendering (RGB)
  - ✅ Set default fonts for monospace, sansSerif, serif, and emoji
  - ✅ Enabled antialiasing and 32-bit font cache support

### Hardware Optimization  
- [x] **Improve graphics configuration** in `system.nix` ✅ COMPLETED
  - ✅ Added Intel GPU hardware acceleration (Gen 5-8+ support)
  - ✅ Enabled 32-bit graphics support for compatibility
  - ✅ Added VAAPI and VDPAU drivers for video acceleration
  - ✅ Enabled CPU microcode updates and proprietary firmware

## 🧹 Cleanup & Maintenance

### Fix TODOs
- [ ] **Fix or remove broken dnscrypt-proxy** in `system.nix` lines 34-39
  - Either fix the AdGuard configuration
  - Or remove the broken static.adguard section
- [ ] **Review all inline TODO comments**
  - Address or remove TODO comments throughout codebase

### Code Quality
- [ ] **Remove duplicate xserver.desktopManager.xterm.enable** 
  - Present in both `packages.nix` and `i3.nix`
- [ ] **Standardize module structure**
  - Ensure consistent parameter ordering across modules
  - Use consistent formatting and comments

## 🎯 Feature Enhancements

### System Services
- [ ] **Add backup configuration**
  - Create `modules/backup.nix` with Restic backup setup
  - Configure automated backups to cloud storage
- [ ] **Improve Docker configuration** in `container.nix`
  - Add storage driver optimization
  - Add logging configuration
  - Add storage options for overlay2
- [ ] **Enhanced system monitoring** 
  - Expand Prometheus node exporter with more collectors
  - Add systemd, textfile, filesystem, netdev collectors

### Desktop Environment
- [ ] **Add desktop-specific optimizations**
  - Consider adding desktop portal configurations per DE
  - Add theme consistency across applications

## 🔧 Hardware & Driver Improvements

### Audio & Video
- [ ] **Review PipeWire configuration**
  - Consider adding low-latency audio settings
  - Add Bluetooth audio codec support if needed
- [ ] **Optimize VirtualBox setup**
  - Review if VirtualBox host is still needed
  - Consider alternatives like QEMU/KVM

### Network Configuration
- [ ] **Review networking setup**
  - Validate custom DNS configuration
  - Test dnscrypt-proxy2 functionality
  - Consider network security hardening

## 📦 Package Management

### System Packages
- [ ] **Review package necessity**
  - Audit all packages in `packages.nix`
  - Move user-specific packages to home-manager if applicable
- [ ] **Consider package alternatives**
  - Review if all browsers (brave, google-chrome, lynx) are needed
  - Consider lighter alternatives for some utilities

### Development Tools
- [ ] **Organize development packages**
  - Consider creating separate dev environment modules
  - Move IDE/editor configs to home-manager

## 🚀 Advanced Optimizations

### System Performance
- [ ] **Add system tuning**
  - Consider kernel parameters for performance
  - Add SSD optimizations if applicable
- [ ] **Review boot optimization**
  - Consider systemd boot optimizations
  - Review startup services

### Security Hardening
- [ ] **Add security modules**
  - Consider AppArmor or SELinux
  - Add firewall configuration
  - Review service hardening options

---

## Notes
- Items marked as HIGH PRIORITY should be addressed first
- Test changes in a VM or non-production environment
- Consider creating git branches for major refactoring
- Review NixOS manual for best practices before implementing
