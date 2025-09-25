'use client'

import {createClient} from "@/utils/supabase/client";
import {Button, Card, Flex, Link, Text, TextField} from "@radix-ui/themes";
import {Form} from "radix-ui";
import React from "react";


export default function SignUp() {
    const signUpNewUser = async (e: React.FormEvent) => {
        if (!(e.currentTarget instanceof HTMLFormElement)) return;
        e.preventDefault();
        const formData = new FormData(e.currentTarget);

        const email = formData.get("email");
        const password = formData.get("password");

        const supabase = createClient();
        const {data, error} = await supabase.auth.signUp({
            email: email as string,
            password: password as string
        });
    }
    return (
        <div style={{display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '20px'}}>
            <Text>This is a placeholder for the sign-up page.</Text>
            <Card style={{padding: '20px', maxWidth: '60%', minWidth: '400px'}} variant="surface">
                <Form.Root style={{width: '100%'}} onSubmit={signUpNewUser}>
                    <Flex direction="column" gap="4" align="center" justify={"center"}>
                        <Form.Field name="email" style={{width: '100%'}}>
                            <Form.Label>Email</Form.Label>
                            <Form.Control asChild>
                                <TextField.Root size="3" placeholder="Enter your email" type="email"/>
                            </Form.Control>
                            <Form.Message match="valueMissing">Please enter your email</Form.Message>
                            <Form.Message match="typeMismatch">Please enter a valid
                                email</Form.Message>
                        </Form.Field>
                        <Form.Field name="password" style={{width: '100%'}}>
                            <Form.Label>Password</Form.Label>
                            <Form.Control asChild>
                                <TextField.Root size="3" placeholder="Enter your password" type="password"/>
                            </Form.Control>
                            <Form.Message match="valueMissing">Please enter your password</Form.Message>
                        </Form.Field>
                        <Form.Field name="confirmPassword" style={{width: '100%'}}>
                            <Form.Label>Confirm Password</Form.Label>
                            <Form.Control asChild>
                                <TextField.Root size="3" placeholder="Confirm your password" type="password"/>
                            </Form.Control>
                            <Form.Message match="valueMissing">Please confirm your password</Form.Message>
                            <Form.Message match={(value, formData) => value !== formData.get("password")}>Passwords do
                                not match</Form.Message>
                        </Form.Field>

                        <Form.FormSubmit asChild>
                            <Button type="submit" size="3" style={{width: '45%'}}>Sign Up</Button>
                        </Form.FormSubmit>

                        <Link href="/auth/login" style={{textAlign: 'center'}} highContrast>
                            <Text align="center">Already have an account?<br/>Log In</Text>
                        </Link>
                    </Flex>
                </Form.Root>
            </Card>
        </div>
    )
}