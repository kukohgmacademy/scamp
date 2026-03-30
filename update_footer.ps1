
$newFooter = @"
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h3 class="text-white mb-3">BATU SUNRISE<span class="text-blue"> CAMP</span></h3>
                    <p class="text-dim small">Penyedia jasa camping dan outbound profesional dengan standar keamanan
                        tinggi.</p>
                </div>
                <div class="col-lg-2 mb-4">
                    <h5 class="text-white mb-3 text-uppercase">Navigasi</h5>
                    <ul class="list-unstyled small">
                        <li class="mb-2">
                            <a href="index.html" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Beranda
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="about.html" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Tentang Kami
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="paket.html" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Paket
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="gallery.html" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Gallery
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="blog.html" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Blog
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-2 mb-4">
                    <h5 class="text-white mb-3 text-uppercase">NETWORK</h5>
                    <ul class="list-unstyled small">
                        <li class="mb-2">
                            <a href="https://citylightscamp.web.id/" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Citylightscamp Web ID
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="https://paketcampingbatu.web.id/" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Paket Camping Batu Web ID
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="https://batucamping.web.id/" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Batu Camping Web ID
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="https://batugroundcamping.web.id/" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Batu Ground Camping Web ID
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="https://wisatacampingbatu.web.id/" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Wisata Camping Batu Web ID
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="https://campingbatumalang.web.id/" class="text-dim footer-link-item">
                                <i class="fas fa-chevron-right me-2"></i>Camping Batu Malang Web ID
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-4 mb-4">
                    <h5 class="text-white mb-3 text-uppercase">KONTAK</h5>
                    <ul class="list-unstyled small">
                        <li class="mb-3 d-flex align-items-start text-dim">
                            <i class="fab fa-whatsapp footer-icon mt-1" aria-hidden="true"></i>
                            <span><b>WhatsApp:</b><br>0812-3922-5692 (Booking)</span>
                        </li>
                        <li class="mb-3 d-flex align-items-start text-dim">
                            <i class="fas fa-map-marker-alt footer-icon mt-1" aria-hidden="true"></i>
                            <span><b>Alamat:</b><br>Camping Ground Goa Pinus, Jl. Gn. Banyak, Jurangrejo, Pandesari,
                                Kec. Bumiaji, Kota Batu, Jawa Timur 65391</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="border-top border-secondary pt-4 mt-4 text-center">
                <small class="text-dim">&copy; 2026 Batu Sunrise Camp. All Rights Reserved.</small>
            </div>
        </div>
    </footer>
"@

$newCSS = @"

        /* FOOTER PREMIUM */
        footer {
            background: #05080f !important;
            padding: 60px 0 30px !important;
            border-top: 1px solid rgba(255, 255, 255, 0.15) !important;
        }

        .footer-icon {
            color: var(--accent-blue) !important;
            margin-right: 12px !important;
            width: 20px !important;
            text-align: center !important;
            flex-shrink: 0 !important;
        }

        footer a {
            color: #94A3B8 !important;
            text-decoration: none !important;
            transition: 0.3s !important;
        }

        footer a:hover {
            color: var(--accent-blue) !important;
        }

        .footer-link-item {
            display: flex !important;
            align-items: center !important;
        }

        .footer-link-item i {
            font-size: 0.65rem !important;
            color: var(--accent-blue) !important;
            width: 18px !important;
            transition: 0.3s !important;
            margin-right: 0.5rem !important;
        }

        .footer-link-item:hover i {
            transform: translateX(3px) !important;
            color: var(--accent-gold, #F59E0B) !important;
        }
"@

$htmlFiles = Get-ChildItem -Filter *.html

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # 1. Update Footer HTML
    # We look for <footer>...</footer> using regex
    $content = [regex]::Replace($content, "(?s)<footer>.*?</footer>", $newFooter)
    
    # 2. Update Footer CSS
    # We look for the closing </style> tag and insert before it if not already there
    if ($content -notmatch "FOOTER PREMIUM") {
        $content = $content.Replace("</style>", $newCSS + "`n    </style>")
    } else {
        # If it exists, we might want to update it, but for now we skip to avoid duplicates
    }
    
    Set-Content $file.FullName $content -NoNewline
    Write-Host "Updated $($file.Name)"
}
