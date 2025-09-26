import {Grid, Text} from "@radix-ui/themes";
import BaseProvider from "@/app/auth/OAuth/Providers/BaseProvider";
import {FaGoogle} from "react-icons/fa6";


export default function OAuthComponent() {

    return (<>
        <Text align={"center"}>
            Use an auth provider
        </Text>
        <Grid
            columns="repeat(auto-fit, 25px)"
            justify="center"
            align="center"
            gap="4"
            style={{ width: "100%" }}
        >
            <BaseProvider
            providerName={"google"}
            >
                <FaGoogle size={"25"} style={{ cursor: "pointer" }} />
            </BaseProvider>
        </Grid>
    </>)
}