import { Flex, Grid } from "@radix-ui/themes"

export default function AuthLayout({
    children
}: Readonly<{
    children: React.ReactNode
}>) {
    return (
        <Grid columns="1" justify="start" align={{xs: 'start', md: 'center'}} style={{ height: '100vh', padding: '20px' }} gapY={{xs: '10', md: '0'}} gapX="4" rows={{ xs: '1fr 15fr',md: 'auto' }}>
            { children }
        </Grid>
    )
}