/* A freenode #web production in collaboration with Buck */

document.addEventListener('DOMContentLoaded', (event) => {

  /**
   * Taking care of the folding menus first
   */

  const navlis = document.querySelectorAll('#main_navigation li')

  navlis.forEach( navli =>
    navli.addEventListener( 'click', e => {

      const uls = navli.querySelector('ul')

      if( uls) {
        console.log( e)
        navli.classList.toggle( 'closed')
        navli.classList.toggle( 'open')
      }
      e.stopImmediatePropagation();
    })
  )

  /**
   * And then the faq page
   */

  const faqs = document.querySelectorAll( 'ol.faq li')

  faqs.forEach( faq => {
    const a = faq.querySelector( 'a')
    const span = faq.querySelector( 'span')

    a.addEventListener( 'click', e => span.classList.toggle( 'hidden'))
  })
})
