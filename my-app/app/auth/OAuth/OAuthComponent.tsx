import {Grid, Text} from "@radix-ui/themes";
import BaseProvider from "@/app/auth/OAuth/BaseProvider";
import {FaGoogle, FaLinkedin} from "react-icons/fa6";
import "./OAuthComponent.css";

export default function OAuthComponent() {
    return (<>
        <Text align={"center"}>
            Use an auth provider
        </Text>
        <Grid
            columns="repeat(auto-fit, 25px)"
            rows="repeat(auto-fit, 30px)"
            justify="center"
            align="center"
            gap="4"
            style={{ width: "100%" }}
        >
            <BaseProvider
            providerName={"google"}
            >
                <FaGoogle size={"100%"}/>
            </BaseProvider>
            <BaseProvider
                providerName={"linkedin_oidc"}
            >
                <FaLinkedin size={"100%"}/>
            </BaseProvider>
        </Grid>
    </>)
}