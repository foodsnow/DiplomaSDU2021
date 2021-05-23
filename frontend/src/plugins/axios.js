import axios from 'axios'

axios.defaults.baseURL = 'http://139.59.179.254';

axios.defaults.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
};

export default axios;