import React, {useState} from "react";
import styles from "../assets/Registration.module.css";
import TextField from "@material-ui/core/TextField/TextField";
import axios from "../plugins/axios";

const SendEmailAndCode = ({handleChange,form,setStep,regTypes,setToken}) => {

    const handleSubmit = () => {
        axios.post('/auth/validate-otp/',{email:form.email,otp:form.code1+form.code2+form.code3+form.code4}).then(res=>{
            console.log(res);
            setToken(res.data.token)
            setStep(regTypes.FIRST_STEP)
        })
    };

    return(
        <div className={styles.box}>
            <div className={styles.box_title}>
                Введите код
            </div>
            <div className={styles.box_description}>
                Мы отправили письмо с кодом на почту
            </div>
            <div className={styles.code_container}>
                <TextField
                    onChange={(e)=>handleChange(e)}
                    style={{marginTop:'60px',width:'100%',textAlign:'center'}}
                    id="outlined-basic"
                    label=""
                    placeholder="_"
                    name="code1"
                    variant="outlined" />
                <TextField
                    onChange={(e)=>handleChange(e)}
                    style={{marginTop:'60px',width:'100%'}}
                    id="outlined-basic"
                    label=""
                    placeholder="_"
                    name="code2"
                    variant="outlined" />
                <TextField
                    onChange={(e)=>handleChange(e)}
                    style={{marginTop:'60px',width:'100%'}}
                    id="outlined-basic"
                    label=""
                    placeholder="_"
                    name="code3"
                    variant="outlined" />
                <TextField
                    onChange={(e)=>handleChange(e)}
                    style={{marginTop:'60px',width:'100%'}}
                    id="outlined-basic"
                    label=""
                    placeholder="_"
                    name="code4"
                    variant="outlined" />
            </div>
            <div onClick={handleSubmit} className={styles.btn}>
                Отправить мне код
            </div>
        </div>
    )
};

export default SendEmailAndCode;