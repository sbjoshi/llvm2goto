; ModuleID = 'Function10/main.c'
source_filename = "Function10/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = common global i32 0, align 4, !dbg !0

; Function Attrs: noinline nounwind uwtable
define void @other_func1(i32 %z, i32 (i32, i32)* %my_func) #0 !dbg !10 {
entry:
  %z.addr = alloca i32, align 4
  %my_func.addr = alloca i32 (i32, i32)*, align 8
  store i32 %z, i32* %z.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %z.addr, metadata !16, metadata !17), !dbg !18
  store i32 (i32, i32)* %my_func, i32 (i32, i32)** %my_func.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %my_func.addr, metadata !19, metadata !17), !dbg !20
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %my_func.addr, align 8, !dbg !21
  %call = call i32 %0(i32 1, i32 2), !dbg !21
  ret void, !dbg !22
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define void @other_func2(i32 %z, i32 (i32, i32)* %my_func, i32 %y) #0 !dbg !23 {
entry:
  %z.addr = alloca i32, align 4
  %my_func.addr = alloca i32 (i32, i32)*, align 8
  %y.addr = alloca i32, align 4
  store i32 %z, i32* %z.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %z.addr, metadata !26, metadata !17), !dbg !27
  store i32 (i32, i32)* %my_func, i32 (i32, i32)** %my_func.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %my_func.addr, metadata !28, metadata !17), !dbg !29
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !30, metadata !17), !dbg !31
  ret void, !dbg !32
}

; Function Attrs: noinline nounwind uwtable
define void @my_f1(i32* %array) #0 !dbg !33 {
entry:
  %array.addr = alloca i32*, align 8
  store i32* %array, i32** %array.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %array.addr, metadata !37, metadata !17), !dbg !38
  ret void, !dbg !39
}

; Function Attrs: noinline nounwind uwtable
define i32 @whatnot(i32 %p1, i32 %p2) #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  %p1.addr = alloca i32, align 4
  %p2.addr = alloca i32, align 4
  store i32 %p1, i32* %p1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %p1.addr, metadata !41, metadata !17), !dbg !42
  store i32 %p2, i32* %p2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %p2.addr, metadata !43, metadata !17), !dbg !44
  %0 = load i32, i32* %p2.addr, align 4, !dbg !45
  store i32 %0, i32* @global, align 4, !dbg !46
  %1 = load i32, i32* %retval, align 4, !dbg !47
  ret i32 %1, !dbg !47
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !48 {
entry:
  %p = alloca i32*, align 8
  call void @llvm.dbg.declare(metadata i32** %p, metadata !51, metadata !17), !dbg !52
  %0 = load i32*, i32** %p, align 8, !dbg !53
  call void @my_f1(i32* %0), !dbg !54
  call void @other_func1(i32 1, i32 (i32, i32)* @whatnot), !dbg !55
  %1 = load i32, i32* @global, align 4, !dbg !56
  %cmp = icmp eq i32 %1, 2, !dbg !57
  %conv = zext i1 %cmp to i32, !dbg !57
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !58
  ret i32 0, !dbg !59
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8}
!llvm.ident = !{!9}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "global", scope: !2, file: !3, line: 3, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "Function10/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{!"clang version 5.0.0 (trunk 295264)"}
!10 = distinct !DISubprogram(name: "other_func1", scope: !3, file: !3, line: 5, type: !11, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !6, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DISubroutineType(types: !15)
!15 = !{!6, !6, !6}
!16 = !DILocalVariable(name: "z", arg: 1, scope: !10, file: !3, line: 5, type: !6)
!17 = !DIExpression()
!18 = !DILocation(line: 5, column: 22, scope: !10)
!19 = !DILocalVariable(name: "my_func", arg: 2, scope: !10, file: !3, line: 5, type: !13)
!20 = !DILocation(line: 5, column: 29, scope: !10)
!21 = !DILocation(line: 7, column: 3, scope: !10)
!22 = !DILocation(line: 8, column: 1, scope: !10)
!23 = distinct !DISubprogram(name: "other_func2", scope: !3, file: !3, line: 10, type: !24, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!24 = !DISubroutineType(types: !25)
!25 = !{null, !6, !13, !6}
!26 = !DILocalVariable(name: "z", arg: 1, scope: !23, file: !3, line: 10, type: !6)
!27 = !DILocation(line: 10, column: 22, scope: !23)
!28 = !DILocalVariable(name: "my_func", arg: 2, scope: !23, file: !3, line: 10, type: !13)
!29 = !DILocation(line: 10, column: 29, scope: !23)
!30 = !DILocalVariable(name: "y", arg: 3, scope: !23, file: !3, line: 10, type: !6)
!31 = !DILocation(line: 10, column: 56, scope: !23)
!32 = !DILocation(line: 12, column: 1, scope: !23)
!33 = distinct !DISubprogram(name: "my_f1", scope: !3, file: !3, line: 16, type: !34, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!34 = !DISubroutineType(types: !35)
!35 = !{null, !36}
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!37 = !DILocalVariable(name: "array", arg: 1, scope: !33, file: !3, line: 16, type: !36)
!38 = !DILocation(line: 16, column: 16, scope: !33)
!39 = !DILocation(line: 18, column: 1, scope: !33)
!40 = distinct !DISubprogram(name: "whatnot", scope: !3, file: !3, line: 20, type: !14, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!41 = !DILocalVariable(name: "p1", arg: 1, scope: !40, file: !3, line: 20, type: !6)
!42 = !DILocation(line: 20, column: 17, scope: !40)
!43 = !DILocalVariable(name: "p2", arg: 2, scope: !40, file: !3, line: 20, type: !6)
!44 = !DILocation(line: 20, column: 25, scope: !40)
!45 = !DILocation(line: 22, column: 10, scope: !40)
!46 = !DILocation(line: 22, column: 9, scope: !40)
!47 = !DILocation(line: 23, column: 1, scope: !40)
!48 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 25, type: !49, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !2, variables: !4)
!49 = !DISubroutineType(types: !50)
!50 = !{!6}
!51 = !DILocalVariable(name: "p", scope: !48, file: !3, line: 27, type: !36)
!52 = !DILocation(line: 27, column: 8, scope: !48)
!53 = !DILocation(line: 28, column: 9, scope: !48)
!54 = !DILocation(line: 28, column: 3, scope: !48)
!55 = !DILocation(line: 30, column: 3, scope: !48)
!56 = !DILocation(line: 31, column: 10, scope: !48)
!57 = !DILocation(line: 31, column: 16, scope: !48)
!58 = !DILocation(line: 31, column: 3, scope: !48)
!59 = !DILocation(line: 32, column: 1, scope: !48)