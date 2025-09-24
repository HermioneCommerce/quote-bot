import { Card, Heading, Text } from "@radix-ui/themes";
import SignUp from "./SignUp";
import { createClient } from "@/utils/supabase/server";

/* Placeholder for now */
export default function SignUpPage() {
    const supabase = createClient()
    console.log(process.env)
    return (
    <>
        <Heading align="center" weight="medium" style={{ flexBasis: "start"}}>Sign Up Page</Heading>
        <SignUp />
    </>
    )
}