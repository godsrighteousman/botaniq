-- Migration: Add language_code to public.profiles table
-- Tarih: 2026-07-26

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS language_code TEXT;
