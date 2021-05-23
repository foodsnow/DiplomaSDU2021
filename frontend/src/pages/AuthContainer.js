import React from 'react'
import {Route} from "react-router-dom"
import Registration from "./Registration";


const AuthContainer = () => {
    return(
        <>
            <Route exact path={'/register'} render={()=><Registration/>}/>
        </>
    )
};

export default AuthContainer;