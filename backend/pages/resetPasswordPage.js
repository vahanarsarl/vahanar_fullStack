import { useState } from 'react';
import { useRouter } from 'next/router';
import styles from '../styles/ResetPasswordPage.module.css';

const ResetPasswordPage = () => {
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const router = useRouter();
  const { token } = router.query;

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (newPassword !== confirmPassword) {
      alert('Passwords do not match');
      return;
    }

    const res = await fetch('/api/resetPassword', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ resetToken: token, newPassword }),
    });

    const data = await res.json();
    if (res.status === 200) {
      alert('Password reset successfully');
      router.push('/login');
    } else {
      alert(data.message);
    }
  };

  return (
    <div className={styles.container}>
      <h1 className={styles.title}>Create Password</h1>
      <form onSubmit={handleSubmit} className={styles.form}>
        <input
          type="password"
          placeholder="Create password"
          value={newPassword}
          onChange={(e) => setNewPassword(e.target.value)}
          required
          className={styles.input}
        />
        <input
          type="password"
          placeholder="Confirm password"
          value={confirmPassword}
          onChange={(e) => setConfirmPassword(e.target.value)}
          required
          className={styles.input}
        />
        <div className={styles.checkboxContainer}>
          <input type="checkbox" required />
          <span>
            By tapping on Checking this button, you agreeing to the Vahana{' '}
            <a href="/terms">Terms of Service</a> and{' '}
            <a href="/privacy">privacy policy</a>.
          </span>
        </div>
        <button type="submit" className={styles.button}>Sign Up</button>
      </form>
    </div>
  );
};

export default ResetPasswordPage;