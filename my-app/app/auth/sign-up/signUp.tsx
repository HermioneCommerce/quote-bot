'use client'

import { Button, Card, Flex, TextField, Text } from "@radix-ui/themes";
import { Form } from "radix-ui";
import React from "react";

export default function SignUp() {
    const handleSubmit = (e: React.FormEvent) => {
        if (!(e.currentTarget instanceof HTMLFormElement)) return;
        e.preventDefault();
        const formData = new FormData(e.currentTarget);
        console.log(formData);
        const email = formData.get("email");
        const password = formData.get("password");
        const confirmPassword = formData.get("confirmPassword");
        if (password !== confirmPassword) {
            alert("Passwords do not match");
            return;
        }
        console.log({ email, password, confirmPassword });
    }
    return (
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '20px' }}>
            <Text >This is a placeholder for the sign-up page.</Text>
            <Card style={{ padding: '20px', maxWidth: '60%', minWidth: '400px' }} variant="surface">
                <Form.Root style={{ width: '100%' }} onSubmit={handleSubmit}>
                    <Flex direction="column" gap="4" align="center" justify={"center"}>
                        <Form.Field name="email" style={{ width: '100%' }}>
                            <Form.Label>Email</Form.Label>
                            <Form.Control asChild>
                                <TextField.Root size="3" placeholder="Enter your email" type="email"/>
                            </Form.Control>
                            <Form.Message match="valueMissing">Please enter your email</Form.Message>
                            <Form.Message match={(value) => !/\S+@\S+\.\S+/.test(value)}>Please enter a valid email</Form.Message>
                        </Form.Field>
                        <Form.Field name="password" style={{ width: '100%' }}>
                            <Form.Label>Password</Form.Label>
                            <Form.Control asChild>
                                <TextField.Root size="3" placeholder="Enter your password" type="password"/>
                            </Form.Control>
                            <Form.Message match="valueMissing">Please enter your password</Form.Message>
                        </Form.Field>
                        <Form.Field name="confirmPassword" style={{ width: '100%' }}>
                            <Form.Label>Confirm Password</Form.Label>
                            <Form.Control asChild>
                                <TextField.Root size="3" placeholder="Confirm your password" type="password"/>
                            </Form.Control>
                            <Form.Message match="valueMissing">Please confirm your password</Form.Message>
                            <Form.Message match={(value, formData) => value !== formData.get("password")}>Passwords do not match</Form.Message>
                        </Form.Field>
                        <Button type="submit" variant="ghost" size="3" style={{ alignSelf: "center" }}>Sign Up</Button>
                    </Flex>
                </Form.Root>
            </Card>
        </div>
    )
}