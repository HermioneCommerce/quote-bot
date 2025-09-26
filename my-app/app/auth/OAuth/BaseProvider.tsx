'use client'
import React from "react";
import {Box} from "@radix-ui/themes";
import {createClient} from "@/utils/supabase/client";
import {useRouter} from "next/navigation";
import {Provider} from "@supabase/auth-js";

type BaseProviderProps = {
    providerName: Provider;
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
        <Box onClick={handleSignIn} className={"oath-btn"} maxWidth={"35px"} width={"25px"}>
            {props.children}
        </Box>
    )
}