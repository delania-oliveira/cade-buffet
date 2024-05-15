const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,html}'

  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'background': 'hsl(0 0% 100%)',
        'foreground': 'hsl(240 10% 3.9%)',
        'card': 'hsl(0 0% 100%)',    
        'card-foreground': 'hsl(240 10% 3.9%)',
        'popover': 'hsl(0 0% 100%)',
        'popover-foreground': 'hsl(240 10% 3.9%)',    
        'primary': 'hsl(346.8 77.2% 49.8%)',    
        'primary-foreground': 'hsl(355.7 100% 97.3%)',    
        'secondary': 'hsl(240 4.8% 95.9%)',    
        'secondary-foreground': 'hsl(240 5.9% 10%)',    
        'muted': 'hsl(240 4.8% 95.9%)',    
        'muted-foreground': 'hsl(240 3.8% 46.1%)',    
        'accent': 'hsl(240 4.8% 95.9%)',    
        'accent-foreground': 'hsl(240 5.9% 10%)',    
        'destructive': 'hsl(0 84.2% 60.2%)',    
        'destructive-foreground': 'hsl(0 0% 98%)',    
        'border': 'hsl(240 5.9% 90%)',    
        'input': 'hsl(240 5.9% 90%)',    
        'ring': 'hsl(346.8 77.2% 49.8%)',    
        'radius': '0.75rem'
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
