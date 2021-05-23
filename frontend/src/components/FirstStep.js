import React from "react";
import { makeStyles } from '@material-ui/core/styles';
import Stepper from '@material-ui/core/Stepper';
import Step from '@material-ui/core/Step';
import StepLabel from '@material-ui/core/StepLabel';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import styles from "../assets/Registration.module.css";
import TextField from '@material-ui/core/TextField';


const useStyles = makeStyles((theme) => ({
    root: {
        width: '100%',
    },
    backButton: {
        marginRight: theme.spacing(1),
    },
    instructions: {
        marginTop: theme.spacing(1),
        marginBottom: theme.spacing(1),
    },
}));

function getSteps() {
    return ['', '', '','',''];
}

const FirstStep = () => {
    const [activeStep, setActiveStep] = React.useState(0);
    const steps = getSteps();

    return(
        <div className={styles.box2}>
            <Stepper activeStep={activeStep} alternativeLabel>
                {steps.map((label) => (
                    <Step key={label}>
                        <StepLabel>{label}</StepLabel>
                    </Step>
                ))}
            </Stepper>
            <div style={{padding:'0 64px',marginTop:'20px'}} className={styles.box_title2}>
                Этап 1
            </div>
            <div style={{padding:'0 64px'}} className={styles.box_description}>
                Напишите ваше имя и фамилию для проверки
                совпадения с ИИН
            </div>
            <div className={styles.forms}>
                <TextField style={{marginTop:'25px'}} className={styles.textField_ui} id="outlined-basic" label="Имя" variant="outlined" />
                <TextField style={{marginTop:'25px'}} className={styles.textField_ui} id="outlined-basic" label="Фамилия" variant="outlined" />
                <TextField style={{marginTop:'25px'}} className={styles.textField_ui} id="outlined-basic" label="ИИН" variant="outlined" />
            </div>
            <div style={{padding:'0 64px'}}>
                <div className={styles.btn}>
                    Далее
                </div>
            </div>
        </div>
    )
};

export default FirstStep;