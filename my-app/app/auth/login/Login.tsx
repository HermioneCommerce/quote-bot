'use client'
import {Box, Button, Card, Flex, Link, Text, TextField} from "@radix-ui/themes";
import {Form} from "radix-ui";
import {createClient} from "@/utils/supabase/client";
import {useRouter} from "next/navigation";
import OAuthComponent from "@/app/auth/OAuth/OAuthComponent";

export default function Login() {
    const router = useRouter();
    const handleLogin = async (e: React.FormEvent) => {
        if (!(e.currentTarget instanceof HTMLFormElement)) return;
        e.preventDefault();
        const formData = new FormData(e.currentTarget);

        const email = formData.get("email") as string;
        const password = formData.get("password") as string;

        const supabase = createClient();

        const {data, error} = await supabase.auth.signInWithPassword({
            email,
            password,
        });

        if (error) {
            console.error('Login error:', error);
            return;
        }

        if (data.user) {
            console.log('Login successful, redirecting...');
            router.push('/');
        }
    }
    return (<>
        <Box width="66%" style={{
            justifySelf: 'center',
            justifyItems: 'center',
            alignItems: 'center',
            display: 'flex',
            flexDirection: 'column',
            gap: '20px'
        }}>
            <Text style={{textAlign: 'center'}} size="6">This is a placeholder for the login page.</Text>
            <Card style={{padding: '20px', maxWidth: '60%', minWidth: '400px', height: 'max-content'}} variant="surface">
                <Flex gap={"25px"} direction={"column"} flexGrow={"1"}>
                    <Form.Root style={{width: '100%'}} onSubmit={handleLogin}>
                        <Flex direction="column" gap="4" align="center" justify={"center"}>
                            <Form.Field name="email" style={{width: '100%'}}>
                                <Form.Label>Email</Form.Label>
                                <Form.Control asChild>
                                    <TextField.Root size="3" placeholder="Enter your email" type="email" required/>
                                </Form.Control>
                                <Form.Message match="valueMissing">Please enter your email</Form.Message>
                                <Form.Message match="typeMismatch">Please enter a valid
                                    email</Form.Message>
                            </Form.Field>

                            <Form.Field name="password" style={{width: '100%'}}>
                                <Form.Label>Password</Form.Label>
                                <Form.Control asChild>
                                    <TextField.Root size="3" placeholder="Enter your password" type="password" required/>
                                </Form.Control>
                                <Form.Message match="valueMissing">Please enter your password</Form.Message>
                            </Form.Field>

                            <Form.FormSubmit asChild>
                                <Button type="submit" size="3" style={{width: '45%'}}>Log In</Button>
                            </Form.FormSubmit>
                        </Flex>
                    </Form.Root>

                    <OAuthComponent />

                    <Link href="/auth/sign-up" style={{textAlign: 'center'}} highContrast>
                        <Text align="center">Need an account?<br/>Sign Up</Text>
                    </Link>
                </Flex>
            </Card>
        </Box>
    </>)
}