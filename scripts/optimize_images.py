#!/usr/bin/env python3
"""
图片优化脚本
用于压缩assets/images目录下的图片文件
"""

import os
import sys
from PIL import Image
import argparse

def optimize_image(input_path, output_path, quality=85, max_size=(1024, 1024)):
    """
    优化单个图片文件
    
    Args:
        input_path: 输入图片路径
        output_path: 输出图片路径
        quality: JPEG质量 (1-100)
        max_size: 最大尺寸 (width, height)
    """
    try:
        with Image.open(input_path) as img:
            # 转换为RGB模式（如果是RGBA，保持透明通道）
            if img.mode in ('RGBA', 'LA'):
                # 保持透明通道
                pass
            elif img.mode != 'RGB':
                img = img.convert('RGB')
            
            # 调整尺寸（保持宽高比）
            if img.size[0] > max_size[0] or img.size[1] > max_size[1]:
                img.thumbnail(max_size, Image.Resampling.LANCZOS)
            
            # 保存优化后的图片
            if img.mode in ('RGBA', 'LA'):
                img.save(output_path, 'PNG', optimize=True)
            else:
                img.save(output_path, 'JPEG', quality=quality, optimize=True)
            
            # 计算压缩比例
            original_size = os.path.getsize(input_path)
            optimized_size = os.path.getsize(output_path)
            compression_ratio = (1 - optimized_size / original_size) * 100
            
            print(f"✅ {input_path} -> {output_path}")
            print(f"   原始大小: {original_size / 1024:.1f}KB")
            print(f"   优化后: {optimized_size / 1024:.1f}KB")
            print(f"   压缩率: {compression_ratio:.1f}%")
            
    except Exception as e:
        print(f"❌ 处理 {input_path} 时出错: {e}")

def optimize_directory(input_dir, output_dir, quality=85, max_size=(1024, 1024)):
    """
    优化目录中的所有图片
    
    Args:
        input_dir: 输入目录
        output_dir: 输出目录
        quality: JPEG质量
        max_size: 最大尺寸
    """
    # 支持的图片格式
    image_extensions = {'.jpg', '.jpeg', '.png', '.bmp', '.tiff', '.webp'}
    
    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)
    
    total_files = 0
    processed_files = 0
    
    for root, dirs, files in os.walk(input_dir):
        # 计算相对路径
        rel_path = os.path.relpath(root, input_dir)
        output_root = os.path.join(output_dir, rel_path)
        
        # 创建对应的输出目录
        os.makedirs(output_root, exist_ok=True)
        
        for file in files:
            file_path = os.path.join(root, file)
            file_ext = os.path.splitext(file)[1].lower()
            
            if file_ext in image_extensions:
                total_files += 1
                output_path = os.path.join(output_root, file)
                
                try:
                    optimize_image(file_path, output_path, quality, max_size)
                    processed_files += 1
                except Exception as e:
                    print(f"❌ 处理 {file_path} 失败: {e}")
    
    print(f"\n📊 总结:")
    print(f"   总文件数: {total_files}")
    print(f"   成功处理: {processed_files}")
    print(f"   失败: {total_files - processed_files}")

def main():
    parser = argparse.ArgumentParser(description='图片优化工具')
    parser.add_argument('input', help='输入目录或文件路径')
    parser.add_argument('-o', '--output', help='输出目录或文件路径')
    parser.add_argument('-q', '--quality', type=int, default=85, help='JPEG质量 (1-100)')
    parser.add_argument('-s', '--max-size', type=int, nargs=2, default=[1024, 1024], 
                       help='最大尺寸 (width height)')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.input):
        print(f"❌ 输入路径不存在: {args.input}")
        sys.exit(1)
    
    if os.path.isdir(args.input):
        # 处理目录
        output_dir = args.output or f"{args.input}_optimized"
        optimize_directory(args.input, output_dir, args.quality, tuple(args.max_size))
    else:
        # 处理单个文件
        output_path = args.output or f"{os.path.splitext(args.input)[0]}_optimized{os.path.splitext(args.input)[1]}"
        optimize_image(args.input, output_path, args.quality, tuple(args.max_size))

if __name__ == '__main__':
    main()
