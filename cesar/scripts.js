const alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
const numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

function rotateNumber(number, rotation) {
  return number + (rotation % 10) >= 0 ?
    (number + (rotation % 10)) % 10 :
    10 + (number + (rotation % 10))
}

function rotateText(pos, rotation) {
  const alphabetLength = alphabet.length

  if (rotation > 0) {
    return pos + rotation >= alphabetLength ?
      (pos + rotation) - alphabetLength :
      pos + rotation
  }

  return pos + rotation < 0 ?
    (pos + rotation) + alphabetLength :
    pos + rotation
}

function encrypt(text, rotation = 0) {
  const textSplited = text.split('')
  const textEncrypted = []

  textSplited.forEach((character) => {
    const isANumber = numbers.includes(character)

    if (isANumber) {
      textEncrypted.push(rotateNumber(Number(character), rotation))

      return
    }

    const pos = alphabet.indexOf(character.toUpperCase())

    if (pos < 0) {
      textEncrypted.push(character)

      return
    }

    const newPos = rotateText(pos, rotation)
    const isLowerCase = character === alphabet[pos].toLowerCase()

    textEncrypted.push(isLowerCase ? alphabet[newPos].toLowerCase() : alphabet[newPos])
  })

  return textEncrypted.join('')
}

function hanldeTextFormSubmit(event) {
  event.preventDefault()

  const textFormData = new FormData(event.target)
  const {
    text,
    rotation
  } = Object.fromEntries(textFormData)

  const textEncrypted = encrypt(text, Number(rotation))

  const result = document.getElementById('result')
  result.innerHTML = ''
  result.innerHTML = textEncrypted
}

function main() {
  const textForm = document.getElementById('text-form')

  textForm.onsubmit = hanldeTextFormSubmit
}

main()