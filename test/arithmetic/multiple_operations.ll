; ModuleID = 'arithmetic/multiple_operations.c'
source_filename = "arithmetic/multiple_operations.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %l = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %o = alloca i32, align 4
  %p = alloca i32, align 4
  %q = alloca i32, align 4
  %r = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  store i32 1, i32* %i, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !11), !dbg !14
  store i32 2, i32* %j, align 4, !dbg !14
  call void @llvm.dbg.declare(metadata i32* %k, metadata !15, metadata !11), !dbg !16
  store i32 3, i32* %k, align 4, !dbg !16
  call void @llvm.dbg.declare(metadata i32* %l, metadata !17, metadata !11), !dbg !18
  store i32 4, i32* %l, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %m, metadata !19, metadata !11), !dbg !20
  store i32 5, i32* %m, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata i32* %n, metadata !21, metadata !11), !dbg !22
  store i32 6, i32* %n, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %o, metadata !23, metadata !11), !dbg !24
  store i32 7, i32* %o, align 4, !dbg !24
  call void @llvm.dbg.declare(metadata i32* %p, metadata !25, metadata !11), !dbg !26
  store i32 8, i32* %p, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata i32* %q, metadata !27, metadata !11), !dbg !28
  store i32 9, i32* %q, align 4, !dbg !28
  call void @llvm.dbg.declare(metadata i32* %r, metadata !29, metadata !11), !dbg !30
  store i32 0, i32* %r, align 4, !dbg !30
  %0 = load i32, i32* %j, align 4, !dbg !31
  %1 = load i32, i32* %k, align 4, !dbg !32
  %add = add nsw i32 %0, %1, !dbg !33
  %2 = load i32, i32* %l, align 4, !dbg !34
  %3 = load i32, i32* %m, align 4, !dbg !35
  %mul = mul nsw i32 %2, %3, !dbg !36
  %4 = load i32, i32* %n, align 4, !dbg !37
  %div = sdiv i32 %mul, %4, !dbg !38
  %5 = load i32, i32* %o, align 4, !dbg !39
  %div1 = sdiv i32 %div, %5, !dbg !40
  %sub = sub nsw i32 %add, %div1, !dbg !41
  %6 = load i32, i32* %p, align 4, !dbg !42
  %add2 = add nsw i32 %sub, %6, !dbg !43
  %7 = load i32, i32* %q, align 4, !dbg !44
  %8 = load i32, i32* %r, align 4, !dbg !45
  %rem = srem i32 %7, %8, !dbg !46
  %add3 = add nsw i32 %add2, %rem, !dbg !47
  store i32 %add3, i32* %i, align 4, !dbg !48
  %9 = load i32, i32* %i, align 4, !dbg !49
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0), i32 %9), !dbg !50
  ret i32 0, !dbg !51
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "arithmetic/multiple_operations.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 2, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 2, column: 5, scope: !6)
!13 = !DILocalVariable(name: "j", scope: !6, file: !1, line: 2, type: !9)
!14 = !DILocation(line: 2, column: 12, scope: !6)
!15 = !DILocalVariable(name: "k", scope: !6, file: !1, line: 2, type: !9)
!16 = !DILocation(line: 2, column: 18, scope: !6)
!17 = !DILocalVariable(name: "l", scope: !6, file: !1, line: 2, type: !9)
!18 = !DILocation(line: 2, column: 23, scope: !6)
!19 = !DILocalVariable(name: "m", scope: !6, file: !1, line: 2, type: !9)
!20 = !DILocation(line: 2, column: 28, scope: !6)
!21 = !DILocalVariable(name: "n", scope: !6, file: !1, line: 2, type: !9)
!22 = !DILocation(line: 2, column: 33, scope: !6)
!23 = !DILocalVariable(name: "o", scope: !6, file: !1, line: 2, type: !9)
!24 = !DILocation(line: 2, column: 38, scope: !6)
!25 = !DILocalVariable(name: "p", scope: !6, file: !1, line: 2, type: !9)
!26 = !DILocation(line: 2, column: 43, scope: !6)
!27 = !DILocalVariable(name: "q", scope: !6, file: !1, line: 2, type: !9)
!28 = !DILocation(line: 2, column: 48, scope: !6)
!29 = !DILocalVariable(name: "r", scope: !6, file: !1, line: 2, type: !9)
!30 = !DILocation(line: 2, column: 53, scope: !6)
!31 = !DILocation(line: 3, column: 5, scope: !6)
!32 = !DILocation(line: 3, column: 7, scope: !6)
!33 = !DILocation(line: 3, column: 6, scope: !6)
!34 = !DILocation(line: 3, column: 9, scope: !6)
!35 = !DILocation(line: 3, column: 11, scope: !6)
!36 = !DILocation(line: 3, column: 10, scope: !6)
!37 = !DILocation(line: 3, column: 13, scope: !6)
!38 = !DILocation(line: 3, column: 12, scope: !6)
!39 = !DILocation(line: 3, column: 15, scope: !6)
!40 = !DILocation(line: 3, column: 14, scope: !6)
!41 = !DILocation(line: 3, column: 8, scope: !6)
!42 = !DILocation(line: 3, column: 17, scope: !6)
!43 = !DILocation(line: 3, column: 16, scope: !6)
!44 = !DILocation(line: 3, column: 19, scope: !6)
!45 = !DILocation(line: 3, column: 21, scope: !6)
!46 = !DILocation(line: 3, column: 20, scope: !6)
!47 = !DILocation(line: 3, column: 18, scope: !6)
!48 = !DILocation(line: 3, column: 3, scope: !6)
!49 = !DILocation(line: 4, column: 13, scope: !6)
!50 = !DILocation(line: 4, column: 1, scope: !6)
!51 = !DILocation(line: 5, column: 1, scope: !6)
