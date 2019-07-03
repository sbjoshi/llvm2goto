; ModuleID = 'typecheck/main.c'
source_filename = "typecheck/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %a1 = alloca i8, align 1
  %unsign = alloca i32, align 4
  %a = alloca double, align 8
  %b = alloca float, align 4
  %c = alloca double, align 8
  %b2 = alloca i64, align 8
  %d = alloca i64, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8* %a1, metadata !11, metadata !DIExpression()), !dbg !13
  store i8 97, i8* %a1, align 1, !dbg !13
  %0 = load i8, i8* %a1, align 1, !dbg !14
  %conv = sext i8 %0 to i32, !dbg !14
  %add = add nsw i32 %conv, 1, !dbg !15
  %conv1 = trunc i32 %add to i8, !dbg !14
  store i8 %conv1, i8* %a1, align 1, !dbg !16
  %1 = load i8, i8* %a1, align 1, !dbg !17
  %conv2 = sext i8 %1 to i32, !dbg !17
  %cmp = icmp eq i32 %conv2, 98, !dbg !18
  %conv3 = zext i1 %cmp to i32, !dbg !18
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %unsign, metadata !20, metadata !DIExpression()), !dbg !22
  store i32 0, i32* %unsign, align 4, !dbg !22
  %2 = load i32, i32* %unsign, align 4, !dbg !23
  %dec = add i32 %2, -1, !dbg !23
  store i32 %dec, i32* %unsign, align 4, !dbg !23
  %3 = load i32, i32* %unsign, align 4, !dbg !24
  %cmp4 = icmp ugt i32 %3, 0, !dbg !25
  %conv5 = zext i1 %cmp4 to i32, !dbg !25
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !26
  call void @llvm.dbg.declare(metadata double* %a, metadata !27, metadata !DIExpression()), !dbg !29
  store double 0x416002BDF3333333, double* %a, align 8, !dbg !29
  call void @llvm.dbg.declare(metadata float* %b, metadata !30, metadata !DIExpression()), !dbg !32
  store float 0x4059028F60000000, float* %b, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata double* %c, metadata !33, metadata !DIExpression()), !dbg !34
  %4 = load double, double* %a, align 8, !dbg !35
  %5 = load float, float* %b, align 4, !dbg !36
  %conv7 = fpext float %5 to double, !dbg !36
  %add8 = fadd double %4, %conv7, !dbg !37
  store double %add8, double* %c, align 8, !dbg !38
  %6 = load double, double* %c, align 8, !dbg !39
  %cmp9 = fcmp oge double %6, 0x416002BDF47AE148, !dbg !40
  %conv10 = zext i1 %cmp9 to i32, !dbg !40
  %call11 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv10), !dbg !41
  call void @llvm.dbg.declare(metadata i64* %b2, metadata !42, metadata !DIExpression()), !dbg !44
  store i64 100, i64* %b2, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata i64* %d, metadata !45, metadata !DIExpression()), !dbg !46
  %7 = load i64, i64* %b2, align 8, !dbg !47
  %sub = sub nsw i64 %7, 0, !dbg !48
  store i64 %sub, i64* %d, align 8, !dbg !46
  %8 = load i64, i64* %d, align 8, !dbg !49
  %9 = load i64, i64* %b2, align 8, !dbg !50
  %cmp12 = icmp eq i64 %8, %9, !dbg !51
  %conv13 = zext i1 %cmp12 to i32, !dbg !51
  %call14 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv13), !dbg !52
  ret i32 0, !dbg !53
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "typecheck/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 8.0.0 "}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !10, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !3)
!11 = !DILocalVariable(name: "a1", scope: !9, file: !1, line: 7, type: !12)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DILocation(line: 7, column: 7, scope: !9)
!14 = !DILocation(line: 8, column: 8, scope: !9)
!15 = !DILocation(line: 8, column: 10, scope: !9)
!16 = !DILocation(line: 8, column: 6, scope: !9)
!17 = !DILocation(line: 10, column: 10, scope: !9)
!18 = !DILocation(line: 10, column: 13, scope: !9)
!19 = !DILocation(line: 10, column: 3, scope: !9)
!20 = !DILocalVariable(name: "unsign", scope: !9, file: !1, line: 13, type: !21)
!21 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!22 = !DILocation(line: 13, column: 16, scope: !9)
!23 = !DILocation(line: 14, column: 9, scope: !9)
!24 = !DILocation(line: 16, column: 10, scope: !9)
!25 = !DILocation(line: 16, column: 16, scope: !9)
!26 = !DILocation(line: 16, column: 3, scope: !9)
!27 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 19, type: !28)
!28 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!29 = !DILocation(line: 19, column: 10, scope: !9)
!30 = !DILocalVariable(name: "b", scope: !9, file: !1, line: 20, type: !31)
!31 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!32 = !DILocation(line: 20, column: 9, scope: !9)
!33 = !DILocalVariable(name: "c", scope: !9, file: !1, line: 21, type: !28)
!34 = !DILocation(line: 21, column: 10, scope: !9)
!35 = !DILocation(line: 22, column: 7, scope: !9)
!36 = !DILocation(line: 22, column: 9, scope: !9)
!37 = !DILocation(line: 22, column: 8, scope: !9)
!38 = !DILocation(line: 22, column: 5, scope: !9)
!39 = !DILocation(line: 24, column: 10, scope: !9)
!40 = !DILocation(line: 24, column: 12, scope: !9)
!41 = !DILocation(line: 24, column: 3, scope: !9)
!42 = !DILocalVariable(name: "b2", scope: !9, file: !1, line: 27, type: !43)
!43 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!44 = !DILocation(line: 27, column: 8, scope: !9)
!45 = !DILocalVariable(name: "d", scope: !9, file: !1, line: 28, type: !43)
!46 = !DILocation(line: 28, column: 8, scope: !9)
!47 = !DILocation(line: 28, column: 12, scope: !9)
!48 = !DILocation(line: 28, column: 15, scope: !9)
!49 = !DILocation(line: 30, column: 10, scope: !9)
!50 = !DILocation(line: 30, column: 15, scope: !9)
!51 = !DILocation(line: 30, column: 12, scope: !9)
!52 = !DILocation(line: 30, column: 3, scope: !9)
!53 = !DILocation(line: 32, column: 3, scope: !9)
