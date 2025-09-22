import { Card, Flex, Link } from "@radix-ui/themes";

export default function Login() {
    return (
        <Card>
            <form>
                <Flex direction="column" gap="4" align="start" style={{ padding: '20px', maxWidth: '400px' }}>
                    <label htmlFor="email">Email:<input type="email" id="email" name="email" required /></label>
                    <label htmlFor="password">Password:<input type="password" id="password" name="password" required /></label>
                    <button type="submit">Sign In</button>
                </Flex>
            </form>
            <Link href="/auth/sign-up">Don't have an account? Sign Up</Link>
        </Card>
    )
}