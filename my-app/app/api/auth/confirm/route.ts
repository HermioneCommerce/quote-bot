import { type NextRequest } from 'next/server'
import { type EmailOtpType } from '@supabase/supabase-js'
import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'


export async function GET(request: NextRequest) {
    const { searchParams } = new URL(request.url)
    const token_hash = searchParams.get('token_hash')
    const type = searchParams.get('type') as EmailOtpType | null
    if (!(token_hash || type)) {
        return
    }
    const next = searchParams.get('next') ?? '/'
    console.log({ token_hash, type, next })
    if (token_hash && type) {
        const supabase = await createClient()

        const { error } = await supabase.auth.verifyOtp({
            type,
            token_hash,
        })
        if (!error) {
            // redirect the user to the page they were before
            redirect(next)
        }
    }

    // redirect the user to an error page with some instructions
    redirect('/auth/login?error=auth_code_error')
}