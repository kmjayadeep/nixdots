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
- [ ] **Create wayland-common.nix module**
  - Extract common Wayland configuration from `sway.nix` and `hyprland.nix`
  - Include: NIXOS_OZONE_WL, xdg.portal, security.polkit
- [ ] **Extract NFS server configuration**
  - Create variables for `truenas.cosmos.cboxlab.com` server name
  - Use variables in all NFS mount definitions in `nfs.nix`

### Module Management
- [ ] **Clean up commented modules** in `default.nix`
  - Remove unused commented imports
  - Or create conditional imports using `lib.optionals`
- [ ] **Organize package categories** in `packages.nix`
  - Group packages by: System, Desktop, Development, Media, Network, Gaming

## ⚡ Performance Optimizations

### Nix Configuration
- [ ] **Enhance Nix settings** in `nixos.nix`
  - Add `max-jobs = "auto"`
  - Add `cores = 0` for all available cores
  - Add Cachix substituters for faster builds
  - Add trusted public keys
- [ ] **Optimize font loading** in `fonts.nix`
  - Add hinting style and subpixel rendering
  - Set default fonts for monospace and sansSerif

### Hardware Optimization  
- [ ] **Improve graphics configuration** in `system.nix`
  - Add GPU-specific optimizations based on hardware
  - Consider hardware acceleration settings

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
