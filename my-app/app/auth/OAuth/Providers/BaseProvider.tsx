'use client'
import React from "react";
import {Box} from "@radix-ui/themes";
import {createClient} from "@/utils/supabase/client";
import {useRouter} from "next/navigation";

type BaseProviderProps = {
    providerName: "google" | "github";
    children: React.ReactNode;
}
export default function BaseProvider(props: BaseProviderProps) {
    const router = useRouter();
    const handleSignIn = async () => {
        const supabase = createClient();
        const {data, error} = await supabase.auth.signInWithOAuth({
            provider: props.providerName,
            options: {
                redirectTo: `${window.location.origin}/api/auth/callback`,
            }
        });
        if (error) {
            console.log(error);
            alert(`Error signing in with ${props.providerName}\n${error.message}`);
        }

        if (data.url) {
            router.push(`${data.url}`);
        }
    }
    return (
        <Box onClick={handleSignIn}>
            {props.children}
        </Box>
    )
}