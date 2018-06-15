; ModuleID = 'float_argc_argv/main.c'
source_filename = "float_argc_argv/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %f = alloca float, align 4
  %g = alloca float, align 4
  %target = alloca float, align 4
  %result = alloca float, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !13, metadata !14), !dbg !15
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata float* %f, metadata !18, metadata !14), !dbg !20
  store float 0x39A9E0C220000000, float* %f, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata float* %g, metadata !21, metadata !14), !dbg !22
  store float 0xBCD3C90140000000, float* %g, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata float* %target, metadata !23, metadata !14), !dbg !24
  store float 0xB6A0000000000000, float* %target, align 4, !dbg !24
  call void @llvm.dbg.declare(metadata float* %result, metadata !25, metadata !14), !dbg !26
  %0 = load float, float* %f, align 4, !dbg !27
  %1 = load float, float* %g, align 4, !dbg !28
  %mul = fmul float %0, %1, !dbg !29
  store float %mul, float* %result, align 4, !dbg !26
  %2 = load float, float* %result, align 4, !dbg !30
  %3 = load float, float* %target, align 4, !dbg !31
  %cmp = fcmp oeq float %2, %3, !dbg !32
  %conv = zext i1 %cmp to i32, !dbg !32
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !33
  ret i32 0, !dbg !34
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "float_argc_argv/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9, !9, !10}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DILocalVariable(name: "argc", arg: 1, scope: !6, file: !1, line: 1, type: !9)
!14 = !DIExpression()
!15 = !DILocation(line: 1, column: 15, scope: !6)
!16 = !DILocalVariable(name: "argv", arg: 2, scope: !6, file: !1, line: 1, type: !10)
!17 = !DILocation(line: 1, column: 28, scope: !6)
!18 = !DILocalVariable(name: "f", scope: !6, file: !1, line: 2, type: !19)
!19 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!20 = !DILocation(line: 2, column: 9, scope: !6)
!21 = !DILocalVariable(name: "g", scope: !6, file: !1, line: 3, type: !19)
!22 = !DILocation(line: 3, column: 9, scope: !6)
!23 = !DILocalVariable(name: "target", scope: !6, file: !1, line: 4, type: !19)
!24 = !DILocation(line: 4, column: 9, scope: !6)
!25 = !DILocalVariable(name: "result", scope: !6, file: !1, line: 6, type: !19)
!26 = !DILocation(line: 6, column: 9, scope: !6)
!27 = !DILocation(line: 6, column: 18, scope: !6)
!28 = !DILocation(line: 6, column: 22, scope: !6)
!29 = !DILocation(line: 6, column: 20, scope: !6)
!30 = !DILocation(line: 8, column: 10, scope: !6)
!31 = !DILocation(line: 8, column: 20, scope: !6)
!32 = !DILocation(line: 8, column: 17, scope: !6)
!33 = !DILocation(line: 8, column: 3, scope: !6)
!34 = !DILocation(line: 10, column: 3, scope: !6)