'use client'
import { createBrowserClient } from '@supabase/ssr'

export function createClient(url: string, pubKey: string) {
    return createBrowserClient(
        process.env.NEXT_PUBLIC_SUPABASE_URL || "",
        process.env.NEXT_PUBLIC_SUPABASE_PUB_KEY || "",
    )
}