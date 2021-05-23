import './App.css';
import AuthContainer from "./pages/AuthContainer";

function App() {

  // if (!localStorage.getItem('token')){
  //   return (
  //       <div>
  //         <AuthContainer/>
  //       </div>
  //   )
  // }
  return (
    <div className="App">
        <AuthContainer/>
    </div>
  );
}

export default App;
