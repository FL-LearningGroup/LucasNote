import { createStore } from  "redux";

let recordState;
const initialState = [];

const reducer = function(state = initialState, action) {
  recordState = state;
  switch(action.type) {
    case "addBook":
      return [
        ...state,
        {
          bookId: action.info.bookId,
          bookName: `<<${action.info.bookName}>>`
        }
      ]
    case "delBook":
      let newState = state.filter((element) => {
        if (element.bookId !=+ action.info.bookId) {
            return true;
        }
        return false;
      })
      return [
        ...newState
      ]
    default:
      return [
        ...state
      ]
    break;
  }
}

const store = createStore(reducer);

const root = document.getElementById('app');
const addBook = document.getElementById("addBook");
const delBook = document.getElementById("delBook");
const bookList = document.getElementById("bookList");

const addBookBtn = document.createElement('button');
const bookNameInput = document.createElement('input');
const delBookBtn = document.createElement('button');
const bookIdInput = document.createElement('input');

addBookBtn.innerText = "Add Book";
delBookBtn.innerText = "Delete Book"

addBookBtn.onclick = () => {addBookFn()};
delBookBtn.onclick = () => {deleteBookFn()};

addBook.appendChild(bookNameInput);
addBook.appendChild(addBookBtn);
delBook.appendChild(bookIdInput);
delBook.appendChild(delBookBtn);

function* generateID() {
  let id = 0;
  while (true) {
    yield id++;
  }
}

const generateId = generateID();
const genBookId = () => generateId.next().value;


function addBookFn() {
  const bookName = bookNameInput.value;
  if (bookName) {
    const bookId = genBookId();
    bookNameInput.value = "";
    const action = {
      type: "addBook",
      info: {
        bookId: bookId,
        bookName: bookName
      }
    }
    store.dispatch(action);
  }
}

function deleteBookFn() {
  const bookId = bookIdInput.value;
  if(bookId) {
    const action = {
      type: 'delBook',
      info: {
        bookId: bookId
      }
    }

    store.dispatch(action);
  }
}

const showState = store.subscribe(() => {
  const currentState = store.getState();
  if(currentState.length !== recordState.length) {
    bookList.innerText = '';
    currentState.forEach((e) => {
      bookList.appendChild(createBookList(e));
    })
  }
})

function createBookList(info) {
  const element = document.createElement('li');
  element.innerText = `BookId: ${info.bookId} BookName: ${info.bookName}`;
  return element;
} 