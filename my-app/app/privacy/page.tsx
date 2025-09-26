import {Box, Card, Flex, Grid, Heading, Link, Section, Text} from "@radix-ui/themes";


export default function PrivacyPage() {

    return (<>
        <Grid rows={"15vh 85vh"} columns={"1fr 18fr 1fr"} justify="center" align={"center"} gapX={"2"}>
            <Section gridColumn={"2"}>
                <Heading align={"center"}>
                    Privacy Policy
                </Heading>
            </Section>
            <Section gridColumn={"2"} minWidth={"50%"} maxWidth={"100%"}>
                <Flex align={"center"} justify={"center"}>
                    <Box style={{ padding: "2rem" }}>
                        <Text align="left" style={{ marginBottom: "2.5rem" }} size={"5"} as={"p"}>
                            QuoteBot respects your privacy. We only collect limited information needed to let you sign in and use our service.
                        </Text>
                        <Text align="left" style={{ marginBottom: "2rem" }} size={"5"} as={"p"}>
                            When you log in with an OAuth provider (Google or LinkedIn), we receive your email address
                            and, in some cases, your name. This info is stored securely and used solely for account management.
                        </Text>
                        <Text align="left" size={"5"} as={"p"}>
                            We do not share or sell your information, nor use it for advertising.
                            To delete your account or ask questions, contact us at
                            <Link href={"mailto:email@muaazbhyat.co.za"}>email@muaazbhyat.co.za</Link>
                            or <Link href={"mailto:ayaan@devson.co.za"}>ayaan@devson.co.za</Link>.
                        </Text>
                    </Box>
                </Flex>
            </Section>
        </Grid>
    </>)
}