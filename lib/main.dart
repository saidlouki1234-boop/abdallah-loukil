```html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تطبيق النادي الإفريقي - Club Africain 1920</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts: Cairo -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        caRed: {
                            DEFAULT: '#E30613',
                            dark: '#B8000B',
                            light: '#FF333F',
                            glow: 'rgba(227, 6, 19, 0.35)'
                        },
                        caWhite: '#FFFFFF',
                        caDark: '#121212',
                        caCardDark: '#1E1E1E'
                    },
                    fontFamily: {
                        cairo: ['Cairo', 'sans-serif']
                    }
                }
            }
        }
    </script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            scroll-behavior: smooth;
        }
        .glass-panel {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(227, 6, 19, 0.15);
        }
        .dark .glass-panel {
            background: rgba(26, 26, 26, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(227, 6, 19, 0.25);
        }
        .glow-red {
            box-shadow: 0 0 25px rgba(227, 6, 19, 0.4);
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.05);
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #E30613;
            border-radius: 10px;
        }
    </style>
</head>
<body class="bg-gray-50 dark:bg-caDark text-gray-800 dark:text-gray-100 min-h-screen transition-colors duration-300 custom-scrollbar pb-20 md:pb-0">

    <!-- Top Header -->
    <header class="sticky top-0 z-50 glass-panel shadow-md border-b border-caRed/20 transition-all">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-20">
                
                <!-- Logo & Title -->
                <div class="flex items-center space-x-3 space-x-reverse">
                    <div class="relative group cursor-pointer">
                        <div class="w-14 h-14 rounded-full bg-white shadow-md p-1 border-2 border-caRed flex items-center justify-center transform group-hover:scale-105 transition-all duration-300">
                            <!-- CA SVG Logo Graphic -->
                            <svg class="w-10 h-10" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="50" cy="50" r="46" stroke="#E30613" stroke-width="6" fill="#FFFFFF"/>
                                <path d="M25 50 C25 25, 75 25, 75 50 C75 75, 25 75, 25 50 Z" fill="#E30613"/>
                                <path d="M50 20 L55 35 L70 35 L58 44 L62 59 L50 50 L38 59 L42 44 L30 35 L45 35 Z" fill="#FFFFFF"/>
                                <text x="50" y="82" font-family="Cairo" font-weight="900" font-size="16" fill="#E30613" text-anchor="middle">CA 1920</text>
                            </svg>
                        </div>
                        <span class="absolute -top-1 -right-1 flex h-3 w-3">
                            <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-caRed opacity-75"></span>
                            <span class="relative inline-flex rounded-full h-3 w-3 bg-caRed"></span>
                        </span>
                    </div>

                    <div>
                        <h1 class="text-xl sm:text-2xl font-extrabold tracking-tight text-gray-900 dark:text-white flex items-center gap-2">
                            <span>النادي الإفريقي</span>
                            <span class="text-xs bg-caRed text-white px-2 py-0.5 rounded-full font-bold uppercase">1920</span>
                        </h1>
                        <p class="text-xs font-bold text-caRed dark:text-red-400">الإفريقي تعيش 🔴⚪</p>
                    </div>
                </div>

                <!-- Navigation Tabs (Desktop) -->
                <nav class="hidden md:flex items-center space-x-1 space-x-reverse font-semibold text-sm">
                    <button onclick="switchTab('news')" id="tab-btn-news" class="nav-btn active-tab px-4 py-2 rounded-xl transition-all flex items-center gap-2 text-caRed bg-caRed/10">
                        <i class="fa-solid fa-newspaper"></i>
                        <span>الأخبار</span>
                    </button>
                    <button onclick="switchTab('matches')" id="tab-btn-matches" class="nav-btn px-4 py-2 rounded-xl transition-all flex items-center gap-2 hover:text-caRed hover:bg-caRed/10">
                        <i class="fa-solid fa-calendar-days"></i>
                        <span>المباريات</span>
                    </button>
                    <button onclick="switchTab('predict')" id="tab-btn-predict" class="nav-btn px-4 py-2 rounded-xl transition-all flex items-center gap-2 hover:text-caRed hover:bg-caRed/10">
                        <i class="fa-solid fa-chart-line"></i>
                        <span>التوقعات والتشجيع</span>
                    </button>
                    <button onclick="switchTab('social')" id="tab-btn-social" class="nav-btn px-4 py-2 rounded-xl transition-all flex items-center gap-2 hover:text-caRed hover:bg-caRed/10">
                        <i class="fa-solid fa-share-nodes"></i>
                        <span>السوشيال ميديا</span>
                    </button>
                </nav>

                <!-- Actions: Audio & Dark Mode -->
                <div class="flex items-center space-x-2 space-x-reverse">
                    <!-- Audio Chant Player Button -->
                    <button id="audio-toggle-btn" onclick="toggleChant()" title="أهازيج الشعب الإفريقي" class="p-2.5 rounded-xl bg-caRed/10 text-caRed hover:bg-caRed hover:text-white transition-all flex items-center gap-2 font-bold text-xs">
                        <i class="fa-solid fa-music animate-bounce" id="audio-icon"></i>
                        <span class="hidden sm:inline" id="audio-text">الأهازيج</span>
                    </button>

                    <!-- Theme Toggle Button -->
                    <button onclick="toggleDarkMode()" class="p-2.5 rounded-xl bg-gray-200 dark:bg-gray-800 text-gray-700 dark:text-gray-200 hover:bg-caRed hover:text-white transition-all">
                        <i class="fa-solid fa-moon dark:hidden"></i>
                        <i class="fa-solid fa-sun hidden dark:inline"></i>
                    </button>
                </div>
            </div>
        </div>
    </header>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">

        <!-- ================= NEWS SECTION ================= -->
        <section id="section-news" class="tab-content space-y-6">
            
            <!-- Hero Banner -->
            <div class="relative rounded-3xl overflow-hidden shadow-2xl bg-gradient-to-r from-caRed to-red-800 text-white p-6 sm:p-10">
                <div class="absolute -right-10 -bottom-10 opacity-10 pointer-events-none">
                    <i class="fa-solid fa-shield-halved text-[250px]"></i>
                </div>
                <div class="relative z-10 max-w-2xl space-y-4">
                    <span class="inline-block bg-white/20 backdrop-blur-md px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider">الفرع الأول - كرة القدم</span>
                    <h2 class="text-2xl sm:text-4xl font-extrabold leading-tight">استعدادات مكثفة لموقعة القمة وتدريبات مغلقة لكتيبة الإفريقي</h2>
                    <p class="text-white/90 text-sm sm:text-base leading-relaxed">واصل الفريق الأول لكرة القدم بالنادي الإفريقي تحضيراته لللقاء القادم وسط معنويات عالية وتكامل بكامل الزاد البشري.</p>
                    <div class="pt-2 flex items-center gap-4 text-xs font-semibold text-white/80">
                        <span><i class="fa-regular fa-clock ml-1"></i> منذ ساعة واحدة</span>
                        <span><i class="fa-regular fa-eye ml-1"></i> 3.4k مشاهدة</span>
                    </div>
                </div>
            </div>

            <!-- Sport Filters -->
            <div class="flex items-center justify-between flex-wrap gap-4 pb-2 border-b border-gray-200 dark:border-gray-800">
                <h3 class="text-xl font-bold flex items-center gap-2">
                    <i class="fa-solid fa-bolt text-caRed"></i>
                    <span>آخر الأخبار والمستجدات</span>
                </h3>
                <div class="flex gap-2 overflow-x-auto pb-1">
                    <button onclick="filterNews('all')" class="news-filter-btn active-filter px-4 py-1.5 rounded-full text-xs font-bold transition-all bg-caRed text-white">الكل</button>
                    <button onclick="filterNews('football')" class="news-filter-btn px-4 py-1.5 rounded-full text-xs font-bold transition-all bg-gray-200 dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-caRed hover:text-white">⚽ كرة القدم</button>
                    <button onclick="filterNews('basketball')" class="news-filter-btn px-4 py-1.5 rounded-full text-xs font-bold transition-all bg-gray-200 dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-caRed hover:text-white">🏀 كرة السلة</button>
                    <button onclick="filterNews('handball')" class="news-filter-btn px-4 py-1.5 rounded-full text-xs font-bold transition-all bg-gray-200 dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-caRed hover:text-white">🤾 كرة اليد</button>
                </div>
            </div>

            <!-- News Grid -->
            <div id="news-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                
                <!-- News Card 1 -->
                <article class="news-card football glass-panel rounded-2xl overflow-hidden hover:shadow-xl transition-all duration-300 border border-gray-200 dark:border-gray-800 flex flex-col">
                    <div class="relative h-48 bg-gray-300 overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=600&q=80" alt="تدريبات النادي الإفريقي" class="w-full h-full object-cover transform hover:scale-105 transition-duration-500">
                        <span class="absolute top-3 right-3 bg-caRed text-white text-xs font-bold px-2.5 py-1 rounded-lg">كرة القدم</span>
                    </div>
                    <div class="p-5 flex-1 flex flex-col justify-between">
                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 font-semibold mb-2 block"><i class="fa-regular fa-calendar ml-1"></i> اليوم، 14:30</span>
                            <h4 class="font-bold text-lg text-gray-900 dark:text-white hover:text-caRed transition-colors mb-2">تصريح المدرب قبل المواجهة القادمة: "جاهزون لإسعاد جماهير شعب الإفريقي"</h4>
                            <p class="text-xs text-gray-600 dark:text-gray-300 line-clamp-3">أكد المدير الفني خلال المؤتمر الصحفي أن جميع اللاعبين في أعلى درجات التركيز لحصد النقاط الثلاث وتأكيد الصدارة.</p>
                        </div>
                        <div class="mt-4 pt-3 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between text-xs font-bold text-caRed">
                            <span>اقرأ المزيد <i class="fa-solid fa-arrow-left mr-1"></i></span>
                            <span class="text-gray-400 font-normal"><i class="fa-solid fa-share-nodes"></i></span>
                        </div>
                    </div>
                </article>

                <!-- News Card 2 -->
                <article class="news-card basketball glass-panel rounded-2xl overflow-hidden hover:shadow-xl transition-all duration-300 border border-gray-200 dark:border-gray-800 flex flex-col">
                    <div class="relative h-48 bg-gray-300 overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=600&q=80" alt="كرة السلة" class="w-full h-full object-cover transform hover:scale-105 transition-duration-500">
                        <span class="absolute top-3 right-3 bg-orange-600 text-white text-xs font-bold px-2.5 py-1 rounded-lg">كرة السلة</span>
                    </div>
                    <div class="p-5 flex-1 flex flex-col justify-between">
                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 font-semibold mb-2 block"><i class="fa-regular fa-calendar ml-1"></i> يوم أمس</span>
                            <h4 class="font-bold text-lg text-gray-900 dark:text-white hover:text-caRed transition-colors mb-2">فرع كرة السلة يحقق انتصاراً ثميناً في قاعة القرجاني</h4>
                            <p class="text-xs text-gray-600 dark:text-gray-300 line-clamp-3">تغلب فريق النادي الإفريقي لكرة السلة على منافسه بعد مباراة حماسية شهدت حضوراً جماهيرياً غفيراً وتشجيعاً منقطع النظير.</p>
                        </div>
                        <div class="mt-4 pt-3 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between text-xs font-bold text-caRed">
                            <span>اقرأ المزيد <i class="fa-solid fa-arrow-left mr-1"></i></span>
                            <span class="text-gray-400 font-normal"><i class="fa-solid fa-share-nodes"></i></span>
                        </div>
                    </div>
                </article>

                <!-- News Card 3 -->
                <article class="news-card handball glass-panel rounded-2xl overflow-hidden hover:shadow-xl transition-all duration-300 border border-gray-200 dark:border-gray-800 flex flex-col">
                    <div class="relative h-48 bg-gray-300 overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1519766304817-4f37bda74a29?auto=format&fit=crop&w=600&q=80" alt="كرة اليد" class="w-full h-full object-cover transform hover:scale-105 transition-duration-500">
                        <span class="absolute top-3 right-3 bg-blue-600 text-white text-xs font-bold px-2.5 py-1 rounded-lg">كرة اليد</span>
                    </div>
                    <div class="p-5 flex-1 flex flex-col justify-between">
                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 font-semibold mb-2 block"><i class="fa-regular fa-calendar ml-1"></i> منذ يومين</span>
                            <h4 class="font-bold text-lg text-gray-900 dark:text-white hover:text-caRed transition-colors mb-2">فرع كرة اليد يواصل تحطيم الأرقام القياسية بالبطولة</h4>
                            <p class="text-xs text-gray-600 dark:text-gray-300 line-clamp-3">رجال كرة اليد يقدمون عروضاً قوية ويضمنون الترشح إلى الدور القادم بنجاح باهر وبأداء دفاعي متميز.</p>
                        </div>
                        <div class="mt-4 pt-3 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between text-xs font-bold text-caRed">
                            <span>اقرأ المزيد <i class="fa-solid fa-arrow-left mr-1"></i></span>
                            <span class="text-gray-400 font-normal"><i class="fa-solid fa-share-nodes"></i></span>
                        </div>
                    </div>
                </article>
            </div>
        </section>

        <!-- ================= MATCHES & SCHEDULE SECTION ================= -->
        <section id="section-matches" class="tab-content hidden space-y-6">
            
            <!-- Countdown Banner Card -->
            <div class="glass-panel rounded-3xl p-6 sm:p-8 border-2 border-caRed/30 relative overflow-hidden text-center bg-gradient-to-b from-caRed/5 to-transparent">
                <span class="inline-block bg-caRed text-white text-xs font-black px-3 py-1 rounded-full uppercase tracking-wider mb-2">المباراة القادمة المهمة</span>
                <h3 class="text-2xl font-black text-gray-900 dark:text-white mb-1">الرابطة المحترفة الأولى - الجولة القادمة</h3>
                <p class="text-xs text-gray-500 dark:text-gray-400 mb-6"><i class="fa-solid fa-location-dot text-caRed"></i> الملعب الأولمبي ببرادس</p>

                <!-- Teams Vs Display -->
                <div class="flex items-center justify-center gap-4 sm:gap-12 my-6">
                    <!-- CA -->
                    <div class="flex flex-col items-center">
                        <div class="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl bg-white shadow-lg p-2 border-2 border-caRed flex items-center justify-center">
                            <svg class="w-16 h-16" viewBox="0 0 100 100" fill="none">
                                <circle cx="50" cy="50" r="46" stroke="#E30613" stroke-width="6" fill="#FFFFFF"/>
                                <path d="M25 50 C25 25, 75 25, 75 50 C75 75, 25 75, 25 50 Z" fill="#E30613"/>
                                <path d="M50 20 L55 35 L70 35 L58 44 L62 59 L50 50 L38 59 L42 44 L30 35 L45 35 Z" fill="#FFFFFF"/>
                            </svg>
                        </div>
                        <span class="font-extrabold text-base sm:text-lg mt-2">النادي الإفريقي</span>
                        <span class="text-xs text-gray-500 font-bold">مستضيف</span>
                    </div>

                    <!-- VS Tag -->
                    <div class="flex flex-col items-center">
                        <span class="text-2xl sm:text-4xl font-black italic text-caRed">VS</span>
                        <span class="text-xs font-bold text-gray-400 bg-gray-100 dark:bg-gray-800 px-2 py-0.5 rounded mt-1">16:30 بتوقيت تونس</span>
                    </div>

                    <!-- Rival -->
                    <div class="flex flex-col items-center">
                        <div class="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl bg-white shadow-lg p-2 border-2 border-gray-300 flex items-center justify-center">
                            <i class="fa-solid fa-shield-halved text-5xl text-gray-600"></i>
                        </div>
                        <span class="font-extrabold text-base sm:text-lg mt-2">النجم الساحلي</span>
                        <span class="text-xs text-gray-500 font-bold">ضيف</span>
                    </div>
                </div>

                <!-- Countdown Timer Container -->
                <div class="grid grid-cols-4 gap-2 max-w-md mx-auto my-6 text-center">
                    <div class="bg-caRed text-white p-3 rounded-2xl shadow-md">
                        <span id="cd-days" class="block text-xl sm:text-3xl font-black">02</span>
                        <span class="text-[10px] sm:text-xs font-bold">أيام</span>
                    </div>
                    <div class="bg-caRed text-white p-3 rounded-2xl shadow-md">
                        <span id="cd-hours" class="block text-xl sm:text-3xl font-black">18</span>
                        <span class="text-[10px] sm:text-xs font-bold">ساعات</span>
                    </div>
                    <div class="bg-caRed text-white p-3 rounded-2xl shadow-md">
                        <span id="cd-minutes" class="block text-xl sm:text-3xl font-black">45</span>
                        <span class="text-[10px] sm:text-xs font-bold">دقائق</span>
                    </div>
                    