import { Flex, Grid } from "@radix-ui/themes"

export default function AuthLayout({
    children
}: Readonly<{
    children: React.ReactNode
}>) {
    return (
        <Grid columns="1" justify="center" align="center" style={{ height: '100vh', padding: '20px' }} rows="1fr, min-content" gapY="1" gapX="4">
            { children }
        </Grid>
    )
}