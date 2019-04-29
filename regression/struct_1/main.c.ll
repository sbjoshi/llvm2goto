; ModuleID = 'struct_1/main.c'
source_filename = "struct_1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Simple = type { i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a1 = alloca i32, align 4
  %b1 = alloca i32, align 4
  %c1 = alloca i32, align 4
  %obj1 = alloca %struct.Simple, align 4
  %obj2 = alloca %struct.Simple, align 4
  %obj3 = alloca %struct.Simple, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a1, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %b1, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %c1, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata %struct.Simple* %obj1, metadata !17, metadata !DIExpression()), !dbg !23
  %0 = load i32, i32* %a1, align 4, !dbg !24
  %a = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !25
  store i32 %0, i32* %a, align 4, !dbg !26
  %1 = load i32, i32* %b1, align 4, !dbg !27
  %b = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !28
  store i32 %1, i32* %b, align 4, !dbg !29
  %2 = load i32, i32* %c1, align 4, !dbg !30
  %c = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 2, !dbg !31
  store i32 %2, i32* %c, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata %struct.Simple* %obj2, metadata !33, metadata !DIExpression()), !dbg !34
  %a2 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !35
  %3 = load i32, i32* %a2, align 4, !dbg !35
  %a3 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 0, !dbg !36
  store i32 %3, i32* %a3, align 4, !dbg !37
  %b4 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !38
  %4 = load i32, i32* %b4, align 4, !dbg !38
  %b5 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 1, !dbg !39
  store i32 %4, i32* %b5, align 4, !dbg !40
  %c6 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 2, !dbg !41
  %5 = load i32, i32* %c6, align 4, !dbg !41
  %c7 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 2, !dbg !42
  store i32 %5, i32* %c7, align 4, !dbg !43
  %a8 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !44
  %6 = load i32, i32* %a8, align 4, !dbg !44
  %a9 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 0, !dbg !45
  %7 = load i32, i32* %a9, align 4, !dbg !45
  %cmp = icmp eq i32 %6, %7, !dbg !46
  br i1 %cmp, label %land.lhs.true, label %land.end, !dbg !47

land.lhs.true:                                    ; preds = %entry
  %b10 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !48
  %8 = load i32, i32* %b10, align 4, !dbg !48
  %b11 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 1, !dbg !49
  %9 = load i32, i32* %b11, align 4, !dbg !49
  %cmp12 = icmp eq i32 %8, %9, !dbg !50
  br i1 %cmp12, label %land.rhs, label %land.end, !dbg !51

land.rhs:                                         ; preds = %land.lhs.true
  %c13 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 2, !dbg !52
  %10 = load i32, i32* %c13, align 4, !dbg !52
  %c14 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 2, !dbg !53
  %11 = load i32, i32* %c14, align 4, !dbg !53
  %cmp15 = icmp eq i32 %10, %11, !dbg !54
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %entry
  %12 = phi i1 [ false, %land.lhs.true ], [ false, %entry ], [ %cmp15, %land.rhs ], !dbg !55
  %land.ext = zext i1 %12 to i32, !dbg !51
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !56
  call void @llvm.dbg.declare(metadata %struct.Simple* %obj3, metadata !57, metadata !DIExpression()), !dbg !58
  %a16 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 0, !dbg !59
  %13 = load i32, i32* %a1, align 4, !dbg !60
  store i32 %13, i32* %a16, align 4, !dbg !59
  %b17 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 1, !dbg !59
  %14 = load i32, i32* %b1, align 4, !dbg !61
  store i32 %14, i32* %b17, align 4, !dbg !59
  %c18 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 2, !dbg !59
  %15 = load i32, i32* %c1, align 4, !dbg !62
  store i32 %15, i32* %c18, align 4, !dbg !59
  %a19 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 0, !dbg !63
  %16 = load i32, i32* %a19, align 4, !dbg !63
  %a20 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 0, !dbg !64
  %17 = load i32, i32* %a20, align 4, !dbg !64
  %cmp21 = icmp eq i32 %16, %17, !dbg !65
  br i1 %cmp21, label %land.lhs.true22, label %land.end30, !dbg !66

land.lhs.true22:                                  ; preds = %land.end
  %b23 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj1, i32 0, i32 1, !dbg !67
  %18 = load i32, i32* %b23, align 4, !dbg !67
  %b24 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj2, i32 0, i32 1, !dbg !68
  %19 = load i32, i32* %b24, align 4, !dbg !68
  %cmp25 = icmp eq i32 %18, %19, !dbg !69
  br i1 %cmp25, label %land.rhs26, label %land.end30, !dbg !70

land.rhs26:                                       ; preds = %land.lhs.true22
  %c27 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 2, !dbg !71
  %20 = load i32, i32* %c27, align 4, !dbg !71
  %c28 = getelementptr inbounds %struct.Simple, %struct.Simple* %obj3, i32 0, i32 2, !dbg !72
  %21 = load i32, i32* %c28, align 4, !dbg !72
  %cmp29 = icmp eq i32 %20, %21, !dbg !73
  br label %land.end30

land.end30:                                       ; preds = %land.rhs26, %land.lhs.true22, %land.end
  %22 = phi i1 [ false, %land.lhs.true22 ], [ false, %land.end ], [ %cmp29, %land.rhs26 ], !dbg !55
  %land.ext31 = zext i1 %22 to i32, !dbg !70
  %call32 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext31), !dbg !74
  ret i32 0, !dbg !75
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "struct_1/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a1", scope: !7, file: !1, line: 9, type: !10)
!12 = !DILocation(line: 9, column: 6, scope: !7)
!13 = !DILocalVariable(name: "b1", scope: !7, file: !1, line: 9, type: !10)
!14 = !DILocation(line: 9, column: 9, scope: !7)
!15 = !DILocalVariable(name: "c1", scope: !7, file: !1, line: 9, type: !10)
!16 = !DILocation(line: 9, column: 12, scope: !7)
!17 = !DILocalVariable(name: "obj1", scope: !7, file: !1, line: 11, type: !18)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Simple", file: !1, line: 2, size: 96, elements: !19)
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !18, file: !1, line: 4, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !18, file: !1, line: 4, baseType: !10, size: 32, offset: 32)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !18, file: !1, line: 4, baseType: !10, size: 32, offset: 64)
!23 = !DILocation(line: 11, column: 16, scope: !7)
!24 = !DILocation(line: 12, column: 11, scope: !7)
!25 = !DILocation(line: 12, column: 7, scope: !7)
!26 = !DILocation(line: 12, column: 9, scope: !7)
!27 = !DILocation(line: 13, column: 11, scope: !7)
!28 = !DILocation(line: 13, column: 7, scope: !7)
!29 = !DILocation(line: 13, column: 9, scope: !7)
!30 = !DILocation(line: 14, column: 11, scope: !7)
!31 = !DILocation(line: 14, column: 7, scope: !7)
!32 = !DILocation(line: 14, column: 9, scope: !7)
!33 = !DILocalVariable(name: "obj2", scope: !7, file: !1, line: 16, type: !18)
!34 = !DILocation(line: 16, column: 16, scope: !7)
!35 = !DILocation(line: 17, column: 16, scope: !7)
!36 = !DILocation(line: 17, column: 7, scope: !7)
!37 = !DILocation(line: 17, column: 9, scope: !7)
!38 = !DILocation(line: 18, column: 16, scope: !7)
!39 = !DILocation(line: 18, column: 7, scope: !7)
!40 = !DILocation(line: 18, column: 9, scope: !7)
!41 = !DILocation(line: 19, column: 16, scope: !7)
!42 = !DILocation(line: 19, column: 7, scope: !7)
!43 = !DILocation(line: 19, column: 9, scope: !7)
!44 = !DILocation(line: 21, column: 14, scope: !7)
!45 = !DILocation(line: 21, column: 24, scope: !7)
!46 = !DILocation(line: 21, column: 16, scope: !7)
!47 = !DILocation(line: 21, column: 26, scope: !7)
!48 = !DILocation(line: 21, column: 34, scope: !7)
!49 = !DILocation(line: 21, column: 44, scope: !7)
!50 = !DILocation(line: 21, column: 36, scope: !7)
!51 = !DILocation(line: 21, column: 46, scope: !7)
!52 = !DILocation(line: 21, column: 54, scope: !7)
!53 = !DILocation(line: 21, column: 64, scope: !7)
!54 = !DILocation(line: 21, column: 56, scope: !7)
!55 = !DILocation(line: 0, scope: !7)
!56 = !DILocation(line: 21, column: 2, scope: !7)
!57 = !DILocalVariable(name: "obj3", scope: !7, file: !1, line: 23, type: !18)
!58 = !DILocation(line: 23, column: 16, scope: !7)
!59 = !DILocation(line: 23, column: 39, scope: !7)
!60 = !DILocation(line: 23, column: 40, scope: !7)
!61 = !DILocation(line: 23, column: 43, scope: !7)
!62 = !DILocation(line: 23, column: 46, scope: !7)
!63 = !DILocation(line: 28, column: 14, scope: !7)
!64 = !DILocation(line: 28, column: 24, scope: !7)
!65 = !DILocation(line: 28, column: 16, scope: !7)
!66 = !DILocation(line: 28, column: 26, scope: !7)
!67 = !DILocation(line: 28, column: 34, scope: !7)
!68 = !DILocation(line: 28, column: 44, scope: !7)
!69 = !DILocation(line: 28, column: 36, scope: !7)
!70 = !DILocation(line: 28, column: 46, scope: !7)
!71 = !DILocation(line: 28, column: 54, scope: !7)
!72 = !DILocation(line: 28, column: 64, scope: !7)
!73 = !DILocation(line: 28, column: 56, scope: !7)
!74 = !DILocation(line: 28, column: 2, scope: !7)
!75 = !DILocation(line: 31, column: 2, scope: !7)
