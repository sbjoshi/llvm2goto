; ModuleID = 'arithmetic/sub.c'
source_filename = "arithmetic/sub.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %k, metadata !15, metadata !11), !dbg !16
  store i32 10, i32* %i, align 4, !dbg !17
  store i32 20, i32* %j, align 4, !dbg !18
  %0 = load i32, i32* %i, align 4, !dbg !19
  %1 = load i32, i32* %j, align 4, !dbg !20
  %sub = sub nsw i32 %0, %1, !dbg !21
  store i32 %sub, i32* %k, align 4, !dbg !22
  %2 = load i32, i32* %k, align 4, !dbg !23
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %2), !dbg !24
  store i32 -1, i32* %k, align 4, !dbg !25
  %3 = load i32, i32* %k, align 4, !dbg !26
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0), i32 %3), !dbg !27
  ret i32 0, !dbg !28
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
!1 = !DIFile(filename: "arithmetic/sub.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
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
!14 = !DILocation(line: 2, column: 7, scope: !6)
!15 = !DILocalVariable(name: "k", scope: !6, file: !1, line: 2, type: !9)
!16 = !DILocation(line: 2, column: 9, scope: !6)
!17 = !DILocation(line: 3, column: 3, scope: !6)
!18 = !DILocation(line: 4, column: 3, scope: !6)
!19 = !DILocation(line: 5, column: 5, scope: !6)
!20 = !DILocation(line: 5, column: 9, scope: !6)
!21 = !DILocation(line: 5, column: 7, scope: !6)
!22 = !DILocation(line: 5, column: 3, scope: !6)
!23 = !DILocation(line: 6, column: 15, scope: !6)
!24 = !DILocation(line: 6, column: 1, scope: !6)
!25 = !DILocation(line: 7, column: 3, scope: !6)
!26 = !DILocation(line: 8, column: 14, scope: !6)
!27 = !DILocation(line: 8, column: 1, scope: !6)
!28 = !DILocation(line: 9, column: 1, scope: !6)
