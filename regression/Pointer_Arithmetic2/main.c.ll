; ModuleID = 'Pointer_Arithmetic2/main.c'
source_filename = "Pointer_Arithmetic2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@my_array = common dso_local global [100 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !18 {
entry:
  %p = alloca i32*, align 8
  %q = alloca i8*, align 8
  %diff = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32** %p, metadata !21, metadata !DIExpression()), !dbg !22
  store i32* getelementptr inbounds ([100 x i32], [100 x i32]* @my_array, i32 0, i32 0), i32** %p, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i8** %q, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %diff, metadata !25, metadata !DIExpression()), !dbg !26
  %0 = load i32*, i32** %p, align 8, !dbg !27
  %1 = bitcast i32* %0 to i8*, !dbg !28
  store i8* %1, i8** %q, align 8, !dbg !29
  %2 = load i8*, i8** %q, align 8, !dbg !30
  %add.ptr = getelementptr inbounds i8, i8* %2, i64 120, !dbg !30
  store i8* %add.ptr, i8** %q, align 8, !dbg !30
  %3 = load i8*, i8** %q, align 8, !dbg !31
  %4 = bitcast i8* %3 to i32*, !dbg !32
  store i32* %4, i32** %p, align 8, !dbg !33
  %5 = load i32*, i32** %p, align 8, !dbg !34
  store i32 1, i32* %5, align 4, !dbg !35
  %6 = load i32, i32* getelementptr inbounds ([100 x i32], [100 x i32]* @my_array, i64 0, i64 30), align 8, !dbg !36
  %cmp = icmp eq i32 %6, 1, !dbg !37
  %conv = zext i1 %cmp to i32, !dbg !37
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !38
  ret i32 0, !dbg !39
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!14, !15, !16}
!llvm.ident = !{!17}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "my_array", scope: !2, file: !3, line: 1, type: !11, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !10)
!3 = !DIFile(filename: "Pointer_Arithmetic2/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!6, !8}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !{!0}
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 3200, elements: !12)
!12 = !{!13}
!13 = !DISubrange(count: 100)
!14 = !{i32 2, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!18 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 3, type: !19, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !2, retainedNodes: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!9}
!21 = !DILocalVariable(name: "p", scope: !18, file: !3, line: 5, type: !8)
!22 = !DILocation(line: 5, column: 8, scope: !18)
!23 = !DILocalVariable(name: "q", scope: !18, file: !3, line: 6, type: !6)
!24 = !DILocation(line: 6, column: 9, scope: !18)
!25 = !DILocalVariable(name: "diff", scope: !18, file: !3, line: 7, type: !9)
!26 = !DILocation(line: 7, column: 7, scope: !18)
!27 = !DILocation(line: 9, column: 13, scope: !18)
!28 = !DILocation(line: 9, column: 5, scope: !18)
!29 = !DILocation(line: 9, column: 4, scope: !18)
!30 = !DILocation(line: 10, column: 4, scope: !18)
!31 = !DILocation(line: 11, column: 12, scope: !18)
!32 = !DILocation(line: 11, column: 5, scope: !18)
!33 = !DILocation(line: 11, column: 4, scope: !18)
!34 = !DILocation(line: 13, column: 4, scope: !18)
!35 = !DILocation(line: 13, column: 5, scope: !18)
!36 = !DILocation(line: 15, column: 10, scope: !18)
!37 = !DILocation(line: 15, column: 22, scope: !18)
!38 = !DILocation(line: 15, column: 3, scope: !18)
!39 = !DILocation(line: 16, column: 1, scope: !18)
