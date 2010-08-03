" fortunes_movement.vim: Movement over email fortunes with ]] etc. 
"
" DEPENDENCIES:
"   - CountJump.vim, CountJump/Motion.vim, CountJump/TextObjects.vim autoload
"     scripts.
"
" Copyright: (C) 2009-2010 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
"   1.00.003	03-Aug-2010	ENH: Bracket motions to end also work when
"				there's no final fortune delimiter. 
"				FIX: Outer text object must not rely on last
"				fortune line being non-empty. 
"				FIX: Inner text object cannot select last
"				fortune in the buffer when the trailing fortune
"				delimiter is missing, as the end boundary must
"				not be empty and the search cannot go a line
"				beyond the last line. 
"	002	22-Jun-2010	ENH: The normal mode ][ mapping should jump to
"				the beginning of the last line, but the
"				operator-pending and visual mode mappings should
"				include the full last line. 
"	001	03-Oct-2009	file creation

" Avoid installing when in unsupported Vim version. 
if v:version < 700
    finish
endif 

"			Move around fortunes: 
"]]			Go to [count] next start of a fortune. 
"][			Go to [count] next end of a fortune. 
"[[			Go to [count] previous start of a fortune. 
"[]			Go to [count] previous end of a fortune. 
" The normal mode ][ mapping should jump to the beginning of the last line, but
" the operator-pending and visual mode mappings should include the full last
" line. 
call CountJump#Motion#MakeBracketMotion('<buffer>', '', '', '^-- \?\n\zs', '^.*\%(\n-- \?$\|\%$\)', 0, 'n')
call CountJump#Motion#MakeBracketMotion('<buffer>', '', '', '^-- \?\n\zs', '^.*\%(\n\zs-- \?$\|\%$\)', 0, 'ov')

"if			"inner fortune" text object, select [count] fortunes,
"			excluding the fortune separator. 
"af			"a fortune" text object, select [count] fortunes, including
"			the preceding fortune separator. 
call CountJump#TextObject#MakeWithCountSearch('<buffer>', 'f', 'i', 'V', '^-- \?$', '^-- \?$')
call CountJump#TextObject#MakeWithCountSearch('<buffer>', 'f', 'a', 'V', '^-- \?$', '\ze\n-- \?$\|\%$')

" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
