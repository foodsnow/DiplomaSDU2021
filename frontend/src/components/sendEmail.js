import React, {useState} from "react";
import styles from "../assets/Registration.module.css"
import TextField from '@material-ui/core/TextField';
import axios from "../plugins/axios";

const SendEmail = ({handleChange,email,setStep,regTypes}) => {

    const handleSubmit = () => {
        axios.post('/auth/send-otp/',{email}).then(res=>{
            console.log(res);
            setStep(regTypes.SEND_EMAIL_AND_CODE)
        })
    };

    return(
        <div className={styles.box}>
            <div className={styles.box_title}>
                Добро пожаловать!
            </div>
            <div className={styles.box_description}>
                Напишите пожалуйста вашу почту
            </div>
            <TextField
                onChange={(e)=>handleChange(e)}
                style={{marginTop:'60px',width:'100%'}}
                id="outlined-basic"
                label="Почта"
                name="email"
                variant="outlined" />
            <div onClick={handleSubmit} className={styles.btn}>
                Отправить мне код
            </div>
        </div>
    )
};

export default SendEmail;