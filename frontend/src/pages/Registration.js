import React, {useState} from "react";
import styles from "../assets/Registration.module.css"
import SendEmail from "../components/sendEmail";
import SendEmailAndCode from "../components/sendEmailAndCode";
import FirstStep from "../components/FirstStep";

const regTypes = {
    SEND_EMAIL: 'SEND_EMAIL',
    SEND_EMAIL_AND_CODE: 'SEND_EMAIL_AND_CODE',
    FIRST_STEP: 'FIRST_STEP',
    SECOND_STEP: 'SECOND_STEP',
    THIRD_STEP: 'THIRD_STEP',
    FOURTH_STEP : 'FOURTH_STEP',
    FIFTH_STEP : 'FIFTH_STEP'
};

const Registration = () => {
    const [step,setStep] = useState(regTypes.SEND_EMAIL);
    const [token,setToken] = useState(null);

    const [form,setForm] = useState({
        email: '',
        code1: '',
        code2: '',
        code3: '',
        code4: ''
    });


    const handleChange = event => {
        const copy = {...form};
        copy[event.target.name] = event.target.value;
        setForm(copy);
    };


    return(
        <div className={styles.container}>
            {step === regTypes.SEND_EMAIL && (
                <SendEmail
                    regTypes={regTypes}
                    setStep={setStep}
                    email={form.email}
                    handleChange={handleChange}/>
            )}
            {step === regTypes.SEND_EMAIL_AND_CODE && (
                 <SendEmailAndCode
                     setToken={setToken}
                     regTypes={regTypes}
                     setStep={setStep}
                     form={form}
                     handleChange={handleChange}/>
            )}
            {step === regTypes.FIRST_STEP && (
                <FirstStep

                />
            )}
        </div>
    )
};

export default Registration;